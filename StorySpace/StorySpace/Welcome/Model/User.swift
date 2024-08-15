//
//  User.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 9.08.2024.
//

import Foundation
import FirebaseAuth
/// `User`, uygulama içerisindeki bir kullanıcıyı temsil eden bir veri modelidir.
/// Bu yapı, kullanıcının ID'si, adı, e-posta adresi ve katılım tarihini içerir.
struct User: Codable {
    /// Kullanıcının benzersiz kimliği.
    let id: String
    
    /// Kullanıcının adı.
    let name: String
    
    /// Kullanıcının e-posta adresi.
    let email: String
    
    /// Kullanıcının uygulamaya katılım tarihini temsil eden zaman damgası.
    let joined: TimeInterval
    
    
}
