//
//  BodyParameterEncoding.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 12.08.2024.
//

import Foundation

/// `BodyParameterEncoding` enum'ı, HTTP isteğinin gövdesinde kullanılan parametre kodlama yöntemlerini belirtir.
enum BodyParameterEncoding {
    /// JSON formatında kodlama yapılır.
    case jsonEncoding
    
    /// Form URL kodlama yöntemi kullanılır.
    case formUrlEncoding
}
