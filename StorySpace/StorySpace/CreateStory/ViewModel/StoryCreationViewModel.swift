//
//  StoryCreationViewModel.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 9.08.2024.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage

/// `StoryCreationViewModel`, kullanıcı tarafından verilen bilgilere dayanarak hikaye oluşturma sürecini yöneten ViewModel'dir.
///
/// Bu sınıf, kullanıcıdan alınan bilgileri kullanarak bir hikaye oluşturur, OpenAI API'si üzerinden hikaye ve görüntü oluşturur,
/// ve bu bilgileri Firebase Firestore ve Firebase Storage'a kaydeder.
class StoryCreationViewModel: BaseViewModel {
    /// Kullanıcının belirlediği tema.
    @Published var theme: String = ""
    
    /// Hikayenin ana karakterinin adı.
    @Published var mainCharacterName: String = ""
    
    /// Ana karakterin özellikleri.
    @Published var mainCharacterTraits: String = ""
    
    /// Hikayenin geçtiği ortam.
    @Published var setting: String = ""
    
    /// Hikayenin türü.
    @Published var storyType: String = Strings.adventure
    
    /// Hikayede yer alacak özel bir olay.
    @Published var specialEvent: String = ""
    
    /// Hikayenin uzunluğu.
    @Published var storyLength: String = Strings.short
    
    /// Hikayenin oluşturulacağı dil.
    @Published var language: String = Strings.turkish  // Varsayılan olarak Türkçe
    
    /// Oluşturulan hikaye metni.
    @Published var generatedStory: String = ""
    
    /// Oluşturulan hikaye için üretilen görselin URL'si.
    @Published var generatedImage: String = ""
        
    /// Hikayenin başarıyla oluşturulup oluşturulmadığını belirten durum.
    @Published var isStoryGenerated: Bool = false
    
    /// Kullanıcının belirlediği sanat tarzı.
    @Published var artStyle: String = Strings.realistic
    
    /// Kullanıcının belirlediği metin modeli.
    @Published var textModel: String =  NSLocalizedString("gpt-4o", comment: "")
    
    /// Uyarı mesajlarının gösterilmesi için kullanılan değişken.
    @Published var showAlert: Bool = false
    
    @Published var isError : Bool = false
    
    /// Desteklenen hikaye türleri.
    let storyTypes = Strings.storyTypes
    
    /// Desteklenen hikaye uzunlukları.
    let storyLengths = Strings.storyLengths
    
    /// Desteklenen diller.
    let languages = Strings.languages
    
    /// Desteklenen sanat tarzları.
    let artStyles = Strings.artStyles
    
    /// Desteklenen metin modelleri.
    let textModels = Strings.textModels
    
    private var auth = Auth.auth()
    private var db = Firestore.firestore()
    private var storage = Storage.storage()

    /// Kullanıcının girdiği bilgilere dayanarak bir hikaye oluşturur.
    /// Hikaye metni ve görseli OpenAI API'si kullanılarak oluşturulur.
    func createStory() {
           print("Starting story creation...")
           isLoading = true
           isStoryGenerated = false
           
           let storyPrompt: String = {
               if language == Strings.turkish {
                   return """
                   \(storyType) türünde bir hikaye oluştur. Hikaye, \(setting) ortamında \(mainCharacterName) adlı \(mainCharacterTraits) bir karakteri anlatıyor. Hikayenin teması \(theme) ve \(specialEvent) gibi bir olay içeriyor. Hikayenin uzunluğu \(storyLength) olmalı.
                   """
               } else {
                   return """
                   Create a \(storyType) story set in \(setting), featuring a character named \(mainCharacterName) who is \(mainCharacterTraits). The story theme is \(theme) and includes an event where \(specialEvent). The story should be \(storyLength) in length.
                   """
               }
           }()
           print(storyPrompt)
           print(textModel)
           sendMessage(with: storyPrompt) { [weak self] storyText in
               guard let self = self else { return }
               DispatchQueue.main.async {
                   if storyText.starts(with: "Hata:") {
                       self.errorMessage = storyText
                       self.isError = true
                       self.isLoading = false
                   } else {
                       self.generatedStory = storyText
                       self.generateImage(for: storyText, artStyle: self.artStyle ) { image in
                           DispatchQueue.main.async {
                               if let image = image {
                                   print("Generated image URL: \(image)")
                                   self.generatedImage = image
                                   self.isLoading = false
                                   self.isStoryGenerated = true
                               } else {
                                   self.errorMessage = "Görsel oluşturulamadı."
                                   self.isError = true
                                   self.isLoading = false
                               }
                           }
                       }
                   }
               }
           }
       }

    /// Kullanıcı tarafından girilen alanların geçerli olup olmadığını doğrular.
    /// - Returns: Tüm alanlar doluysa `true`, aksi halde `false` döner.
    func validateFields() -> Bool {
        return !theme.isEmpty && !mainCharacterName.isEmpty && !mainCharacterTraits.isEmpty && !setting.isEmpty && !specialEvent.isEmpty
    }
    
    /// Hikaye oluşturma sürecini sıfırlar.
    func resetStory() {
        theme = ""
        mainCharacterName = ""
        mainCharacterTraits = ""
        setting = ""
        storyType = Strings.adventure
        specialEvent = ""
        storyLength = Strings.short
        generatedStory = ""
        generatedImage = ""
        isLoading = false
        isStoryGenerated = false
    }
    
    /// OpenAI API'si üzerinden bir mesaj gönderir ve geri dönen yanıtı alır.
    /// - Parameters:
    ///   - message: OpenAI API'sine gönderilecek mesaj.
    ///   - completion: Mesajın yanıtını döndüren closure.
    func sendMessage(with message: String, completion: @escaping (String) -> Void) {
        print("Sending message to OpenAI API...")
        let request = OpenAIRouter.sendMessage(model: textModel, message: message)
        print(request)
        ApiService.shared.request(request, type: OpenAIChatResponse.self) { result, _ in
            print(result)
            switch result {
            case .success(let response):
                let storyText = response.choices.first?.message.content ?? "No response"
                print("Received response: \(storyText)")
                completion(storyText)
            case .failure(let error):
                completion("Hata: \(error.localizedDescription)")
            }
        }
    }
    
    /// OpenAI API'si üzerinden bir görüntü oluşturur ve geri dönen URL'yi alır.
    /// - Parameters:
    ///   - prompt: Görüntünün oluşturulması için kullanılacak metin isteği.
    ///   - artStyle: Görüntünün oluşturulacağı sanat tarzı.
    ///   - completion: Görüntünün URL'sini döndüren closure.
    private func generateImage(for prompt: String, artStyle: String, completion: @escaping (String?) -> Void) {
        print("Generating image with prompt: \(prompt) and art style: \(artStyle)")
        let request = OpenAIRouter.generateImage(prompt: prompt, artStyle: artStyle)
        print(request)
        ApiService.shared.request(request, type: OpenAIImageResponse.self) { result, _ in
            print(result)
            switch result {
            case .success(let response):
                let imageUrl = response.data.first?.url
                print("Successfully generated image URL: \(imageUrl ?? "No URL")")
                completion(imageUrl)
            case .failure(let error):
                print("Failed to generate image: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    /// Oluşturulan hikayeyi Firebase'e kaydeder.
    /// - Parameters:
    ///   - completion: İşlemin başarılı olup olmadığını döndüren closure.
    func saveStoryToFirebase(completion: @escaping (Bool) -> Void) {
        buttonState = true
        guard auth.currentUser != nil else {
            completion(false)
            return
        }
        
        guard let url = URL(string: generatedImage) else {
            self.errorMessage = Strings.invalidImageURL
            self.buttonState = false
            completion(false)
            return
        }

        ApiService.shared.downloadImage(from: url.absoluteString) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.uploadImageToFirebase(imageData: imageData, completion: completion)
            case .failure(_):
                self?.errorMessage = Strings.downloadImageFailed
                self?.buttonState = false
                completion(false)
            }
        }
    }

    /// İndirilen görüntüyü Firebase Storage'a yükler.
    /// - Parameters:
    ///   - imageData: Yüklenecek görüntü verisi.
    ///   - completion: İşlemin başarılı olup olmadığını döndüren closure.
    private func uploadImageToFirebase(imageData: Data, completion: @escaping (Bool) -> Void) {
        guard let user = auth.currentUser else {
            completion(false)
            return
        }

        let imagePath = "users/\(user.uid)/stories/\(UUID().uuidString).jpg"
        let storageRef = storage.reference(withPath: imagePath)
        
        storageRef.putData(imageData, metadata: nil) { [weak self] metadata, error in
            if error != nil {
                self?.errorMessage = Strings.uploadImageFailed
                self?.buttonState = false
                completion(false)
                return
            }
            
            storageRef.downloadURL { url, error in
                if error != nil {
                    self?.errorMessage = Strings.imageURLFetchFailed
                    self?.buttonState = false
                    completion(false)
                    return
                }
                
                guard let imageUrl = url?.absoluteString else {
                    self?.errorMessage = Strings.imageNotFound
                    self?.buttonState = false
                    completion(false)
                    return
                }
                
                self?.saveStoryToFirestore(imageUrl: imageUrl, completion: completion)
            }
        }
    }
    
    /// Oluşturulan hikayeyi Firebase Firestore'a kaydeder.
    /// - Parameters:
    ///   - imageUrl: Hikaye için oluşturulan görüntünün URL'si.
    ///   - completion: İşlemin başarılı olup olmadığını döndüren closure.
    private func saveStoryToFirestore(imageUrl: String, completion: @escaping (Bool) -> Void) {
        guard let user = auth.currentUser else {
            completion(false)
            return
        }
        
        let storyTypeKey: String
         switch self.storyType {
         case Strings.adventure:
             storyTypeKey = Strings.adventureKey
         case Strings.romantic:
             storyTypeKey = Strings.romanticKey
         case Strings.scienceFiction:
             storyTypeKey = Strings.scienceFictionKey
         case Strings.fear:
             storyTypeKey = Strings.fearKey
         default:
             storyTypeKey = Strings.unknownType
         }
        
        db.collection("users").document(user.uid).collection("stories").addDocument(data: [
            "theme": self.theme,
            "mainCharacterName": self.mainCharacterName,
            "mainCharacterTraits": self.mainCharacterTraits,
            "setting": self.setting,
            "storyType": storyTypeKey,
            "specialEvent": self.specialEvent,
            "storyLength": self.storyLength,
            "generatedStory": self.generatedStory,
            "timestamp": Timestamp(date: Date()),
            "imageUrl": imageUrl
        ]) { [weak self] err in
            if err != nil {
                self?.errorMessage = Strings.saveStoryFailed
                self?.buttonState = false
                completion(false)
            } else {
                self?.buttonState = false
                completion(true)
            }
        }
    }
}
