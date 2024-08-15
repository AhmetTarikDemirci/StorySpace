//
//  LoginViewModel.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 9.08.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

/// `WelcomeViewModel` sınıfı, giriş ve kayıt işlemlerini yöneten ve kullanıcı verilerini işleyen bir ViewModel'dir.
class WelcomeViewModel: BaseViewModel {
    
    /// Kullanıcının kayıt için girdiği ad.
    @Published var name = ""
    
    /// Kullanıcının giriş için girdiği e-posta adresi.
    @Published var email = ""
    
    /// Kullanıcının giriş için girdiği şifre.
    @Published var password = ""

    /// 0: Giriş, 1: Kayıt (Kullanıcı arayüzündeki giriş/kayıt durumunu temsil eder)
    @Published var index: Int = 0
    
    private var auth = Auth.auth()
    private var db = Firestore.firestore()
    
    /// Giriş işlemini başlatır.
    func login() {
        buttonState = true
        guard validate() else {
            buttonState = false
            return
        }
        
        auth.signIn(withEmail: email, password: password) { [weak self] _, error in
            self?.buttonState = false
            if let error = error {
                self?.errorMessage = error.localizedDescription
            }
        }
    }
    
    /// Kayıt işlemini başlatır.
    func register() {
        guard registerValidate() else {
            return
        }
        buttonState = true
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            self?.buttonState = false
            if let error = error {
                self?.errorMessage = error.localizedDescription
                return
            }
            guard let userId = result?.user.uid else {
                return
            }
            self?.insertUserRecord(id: userId)
        }
    }
    
    /// Yeni kullanıcı kaydını Firestore'a ekler.
    /// - Parameter id: Yeni kullanıcının kimliği.
    private func insertUserRecord(id: String) {
        let newUser = User(
            id: id,
            name: name,
            email: email,
            joined: Date().timeIntervalSince1970
        )
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary()) { [weak self] error in
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                }
            }
    }
    
    /// Giriş formundaki verilerin doğruluğunu kontrol eder.
    /// - Returns: Giriş verileri geçerli ise `true`, değilse `false` döner.
    private func validate() -> Bool {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = Strings.fillAllFieldsError
            return false
        }
        guard email.contains("@") && email.contains(".") else {
            errorMessage = Strings.enterValidEmail
            return false
        }
        return true
    }
    
    /// Kayıt formundaki verilerin doğruluğunu kontrol eder.
    /// - Returns: Kayıt verileri geçerli ise `true`, değilse `false` döner.
    private func registerValidate() -> Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.errorMessage = Strings.mandatoryFieldsMissing
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            self.errorMessage = Strings.checkEmailAddress
            return false
        }
        
        guard password.count >= 6 else {
            self.errorMessage = Strings.passwordTooShort
            return false
        }
        
        return true
    }
}
