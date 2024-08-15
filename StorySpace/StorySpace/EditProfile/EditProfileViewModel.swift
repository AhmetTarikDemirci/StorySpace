//
//  EditProfileViewModel.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 14.08.2024.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

/// `EditProfileViewModel` sınıfı, kullanıcının profil bilgilerini düzenlemesine ve Firebase ile eşlemesine olanak tanıyan bir ViewModel'dir.
/// Bu sınıf, kullanıcının adını, e-posta adresini ve şifresini güncelleyerek veritabanına kaydeder.
class EditProfileViewModel: ObservableObject {
    /// Kullanıcının mevcut şifresi.
    @Published var currentPassword: String = ""
    
    /// Kullanıcının yeni şifresi.
    @Published var newPassword: String = ""
    
    /// Kullanıcının adı.
    @Published var name: String = ""
    
    /// Kullanıcının e-posta adresi.
    @Published var email: String = ""
    
    /// Güncelleme işlemi sırasında oluşan hata mesajları.
    @Published var errorMessage: String?
    
    /// Güncelleme işlemi sırasında oluşan başarı mesajları.
    @Published var successMessage: String?
    
    /// Güncelleme işleminin devam edip etmediğini belirten durum.
    @Published var isLoading: Bool = false
    
    /// Kullanıcının bilgilerini tutar.
    @Published var user: User?
    
    private var auth = Auth.auth()
    private var db = Firestore.firestore()
    
    /// `EditProfileViewModel` sınıfını başlatır ve mevcut kullanıcı verilerini yükler.
    init() {
        fetchUserData()
    }
    
    /// Firebase'den kullanıcının mevcut bilgilerini alır ve yerel değişkenlere yükler.
    ///
    /// Bu fonksiyon herhangi bir parametre almaz ve bir değer döndürmez.
    func fetchUserData() {
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
                self.name = self.user?.name ?? ""
                self.email = self.user?.email ?? ""
            }
        }
    }
    
    /// Kullanıcının profil bilgilerini günceller ve Firebase ile eşleştirir.
    ///
    /// Bu fonksiyon herhangi bir parametre almaz ve bir değer döndürmez. İşlem sırasında `errorMessage` ve `successMessage` değişkenleri güncellenir.
    func updateProfile() {
        guard validateFields() else { return }
        isLoading = true
        errorMessage = nil
        
        guard let currentUser = auth.currentUser else {
            errorMessage = Strings.errorUserNotLoggedIn
            isLoading = false
            return
        }
        
        // Kullanıcı adı günceller ve ardından e-posta güncellemesine geçer.
        let changeRequest = currentUser.createProfileChangeRequest()
        changeRequest.displayName = name
        changeRequest.commitChanges { [weak self] error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
                self?.isLoading = false
                return
            }
            self?.updateEmail(user: currentUser)
        }
    }

    /// Kullanıcının e-posta adresini günceller.
    ///
    /// - Parameter user: Güncellenecek olan `FirebaseAuth.User` nesnesi.
    ///
    /// Bu fonksiyon herhangi bir değer döndürmez. E-posta güncellenir ve şifre güncelleme işlemine geçilir.
    private func updateEmail(user: FirebaseAuth.User) {
        user.updateEmail(to: email) { [weak self] error in
            if error != nil {
                self?.errorMessage = Strings.errorUpdateEmailFailed
                self?.isLoading = false
                return
            }
            self?.updatePassword()
        }
    }
    
    /// Kullanıcının şifresini günceller.
    ///
    /// Bu fonksiyon herhangi bir parametre almaz ve bir değer döndürmez. Şifre güncellenir ve veriler Firestore'a kaydedilir.
    func updatePassword() {
        guard let user = auth.currentUser else {
            errorMessage = Strings.errorUserNotFound
            isLoading = false
            return
        }
        
        // Eğer yeni şifre boş ise, şifre güncellenmeden veriler kaydedilir.
        if newPassword.isEmpty {
            saveUserDataToFirestore(user: user)
            return
        }
        
        guard !currentPassword.isEmpty else {
            errorMessage = Strings.errorValidation
            isLoading = false
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: user.email ?? "", password: currentPassword)
        
        isLoading = true
        
        // Kullanıcıyı yeniden doğrular ve ardından şifreyi günceller.
        user.reauthenticate(with: credential) { [weak self] authResult, error in
            if error != nil {
                self?.errorMessage = Strings.errorReauthenticationFailed
                self?.isLoading = false
                return
            }
            
            user.updatePassword(to: self?.newPassword ?? "") { error in
                if error != nil {
                    self?.errorMessage = Strings.errorUpdatePasswordFailed
                } else {
                    self?.successMessage = Strings.successPasswordUpdated
                    self?.currentPassword = ""
                    self?.newPassword = ""
                }
                self?.saveUserDataToFirestore(user: user)
            }
        }
    }

    /// Kullanıcı verilerini Firestore'a kaydeder.
    ///
    /// - Parameter user: Firestore'a kaydedilecek olan `FirebaseAuth.User` nesnesi.
    ///
    /// Bu fonksiyon herhangi bir değer döndürmez. Veriler kaydedilir ve hata/başarı durumu güncellenir.
    private func saveUserDataToFirestore(user: FirebaseAuth.User) {
        db.collection("users").document(user.uid).setData([
            "name": name,
            "email": email
        ], merge: true) { [weak self] error in
            if error != nil {
                self?.errorMessage = Strings.errorDatabaseUpdateFailed
            } else {
                self?.successMessage = Strings.successProfileUpdated
            }
            self?.isLoading = false
        }
    }
    
    /// Giriş alanlarının geçerliliğini kontrol eder.
    ///
    /// - Returns: Giriş verileri geçerli ise `true`, değilse `false` döner.
    private func validateFields() -> Bool {
        if name.isEmpty || email.isEmpty {
            errorMessage = Strings.errorValidation
            return false
        }
        return true
    }
}
