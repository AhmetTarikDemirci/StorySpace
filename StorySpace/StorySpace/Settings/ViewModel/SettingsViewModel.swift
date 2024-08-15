//
//  SettingsViewModel.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 10.08.2024.
//

import Foundation
import SwiftUI
import FirebaseAuth
import Firebase

/// `SettingsViewViewModel` sınıfı, ayar ekranını yönetmek için kullanılan ViewModel'dir.
///
/// Bu sınıf, profil düzenleme, tema değiştirme, hesap silme ve çıkış yapma gibi işlemleri sağlar.
class SettingsViewViewModel: ObservableObject {
    
    /// Profil düzenleme ekranının aktif olup olmadığını belirten durum.
    @Published var isEditProfileActive = false
    
    /// Tema değiştirme durumunu belirten değişken.
    @Published var changeTheme = false
    
    /// Kullanıcı verisi.
    @Published var user: User? = nil
    
    /// Hata veya bilgilendirme amaçlı alert gösterimi için kullanılan değişken.
    @Published var showAlert = false
    
    /// Kullanıcının tema tercihi.
    @AppStorage("userTheme") var userTheme: Theme = .systemDefault
    
    private var auth = Auth.auth()
    private var db = Firestore.firestore()

    /// Temayı değiştirir. `changeTheme` değişkenini tersine çevirir.
    func toggleTheme() {
        changeTheme.toggle()
    }
    
    /// Profil düzenleme ekranını aktif hale getirir.
    func editProfile() {
        isEditProfileActive = true
    }
    
    /// Kullanıcı bilgilerini Firestore'dan getirir.
    /// - Not: Mevcut kullanıcı ID'sine göre Firestore'dan kullanıcı verisi alınır ve `user` değişkenine atanır.
    func fetchUser() {
        guard let userID = auth.currentUser?.uid else {
            return
        }

        db.collection("users").document(userID).getDocument { [weak self] snapshot, error in
            guard let self = self else { return }
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self.user = User(
                    id: data["id"] as? String ?? "",
                    name: data["name"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    joined: data["joined"] as? TimeInterval ?? 0
                )
            }
        }
    }
    
    /// Kullanıcı oturumunu kapatır.
    /// - Not: Oturum kapatma işlemi sırasında bir hata oluşursa, bu hata konsola yazdırılır.
    func logout() {
        do {
            try auth.signOut()
            // Oturum kapatma sonrası yapılacak işlemler, örneğin giriş ekranına yönlendirme
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    /// Kullanıcının hesabını siler.
    /// - Parameters:
    ///   - completion: Hesap silme işleminin sonucunu döndüren bir closure.
    /// - Not: Hesap başarıyla silinirse `completion` closure'ı `success` durumu ile çağrılır, aksi halde `failure` ile hata döndürülür.
    func deleteAccount(completion: @escaping (Result<Void, Error>) -> Void) {
        auth.currentUser?.delete { error in
            if let error = error {
                print("Hesap silinirken hata oluştu: \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                print("Hesap başarıyla silindi")
                completion(.success(()))
                // Hesap silme sonrası yapılacak işlemler, örneğin kayıt ekranına yönlendirme
            }
        }
    }
}
