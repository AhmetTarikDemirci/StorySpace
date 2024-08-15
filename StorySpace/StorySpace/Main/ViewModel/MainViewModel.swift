//
//  MainViewModel.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 9.08.2024.
//

import Foundation
import FirebaseAuth

/// `MainViewModel`, kullanıcı kimlik doğrulama durumunu izleyen ve yöneten bir ViewModel'dir.
class MainViewModel: ObservableObject {
    
    /// Geçerli oturum açmış kullanıcının kimliği.
    @Published var currentUserId: String = ""
    
    /// Firebase kimlik doğrulama durumunu izleyen dinleyici.
    private var handler: AuthStateDidChangeListenerHandle?
    
    /// `MainViewModel` başlatıcısı.
    init() {
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    /// Kullanıcının oturum açıp açmadığını belirten bir durum.
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
