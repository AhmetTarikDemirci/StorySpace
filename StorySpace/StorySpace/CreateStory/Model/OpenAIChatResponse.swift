//
//  OpenAIChatResponse.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 12.08.2024.
//

import Foundation

// MARK: - OpenAIChatResponse

/// `OpenAIChatResponse`, OpenAI'nin chat API'sinden dönen yanıtı temsil eden bir yapıdır.
/// Bu yapı, API'den dönen `choices` dizisini içerir.
struct OpenAIChatResponse: Decodable {
    /// API yanıtındaki seçeneklerin listesi. Her bir seçenek bir `Choice` nesnesi içerir.
    let choices: [Choice]
}

// MARK: - Choice

/// `Choice`, API yanıtında bulunan bir seçeneği temsil eden yapıdır.
/// Her bir seçenek, bir mesaj (`Message`) içerir.
struct Choice: Decodable {
    /// Seçenek içindeki mesaj bilgisi.
    let message: Message
}

// MARK: - Message

/// `Message`, API tarafından döndürülen bir mesajı temsil eden yapıdır.
/// Bu yapı, mesajın rolünü ve içeriğini içerir.
struct Message: Decodable {
    /// Mesajın rolü, örneğin "user" veya "assistant".
    let role: String
    
    /// Mesajın içeriği, metin formatında.
    let content: String
}
