//
//  HomeViewModel.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 10.08.2024.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

/// `HomeViewModel`, ana ekrandaki hikayeleri yönetmek için kullanılan ViewModel'dir.
///
/// Bu sınıf, kullanıcı tarafından oluşturulan hikayeleri Firebase Firestore'dan çeker,
/// türlerine göre gruplar ve hikayelerin silinmesini sağlar.
class HomeViewModel: BaseViewModel {
    /// Kullanıcının tüm hikayelerini içeren dizi.
    @Published var stories: [Story] = []
    
    /// Hikayelerin türlerine göre gruplandırıldığı sözlük.
    @Published var groupedStories: [String: [Story]] = [:]

    private var auth = Auth.auth()
    private var db = Firestore.firestore()

    /// Kullanıcının Firestore'daki hikayelerini çeker.
    func fetchStories() {
        isLoading = true
        errorMessage = ""
        
        guard let user = auth.currentUser else {
            self.isLoading = false
            self.errorMessage = Strings.userNotLoggedIn
            return
        }
        
        db.collection("users").document(user.uid).collection("stories").getDocuments { [weak self] snapshot, error in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    self.errorMessage = Strings.storyNotFound
                    return
                }
                
                self.stories = documents.compactMap { doc in
                    let data = doc.data()
                    let storyTypeKey = data["storyType"] as? String ?? Strings.unknownType
                    let localizedStoryType = NSLocalizedString(storyTypeKey, comment: "")
                    
                    return Story(
                        id: doc.documentID,
                        title: data["theme"] as? String ?? Strings.noTitle,
                        imageUrl: data["imageUrl"] as? String ?? "",
                        content: data["generatedStory"] as? String ?? Strings.noContent,
                        timeStamp: (data["timestamp"] as? Timestamp)?.dateValue().timeIntervalSince1970 ?? 0,
                        storyType: localizedStoryType
                    )
                }
                self.groupStoriesByType()
            }
        }
    }

    
    /// Hikayeleri türlerine göre gruplar.
//    private func groupStoriesByType() {
//        groupedStories = Dictionary(grouping: stories, by: { $0.storyType })
//    }
    private func groupStoriesByType() {
        groupedStories = Dictionary(grouping: stories, by: { story in
            return NSLocalizedString(story.storyType, comment: "")
        })
    }
    
    /// Belirli bir hikayeyi siler.
    /// - Parameter story: Silinmek istenen hikaye.
    func deleteStory(_ story: Story) {
        guard let user = auth.currentUser else { return }
        
        db.collection("users").document(user.uid).collection("stories").document(story.id).delete { [weak self] error in
            if let error = error {
                print("\(Strings.errorDeletingStory): \(error.localizedDescription)")
            } else {
                self?.fetchStories()
            }
        }
    }
}
