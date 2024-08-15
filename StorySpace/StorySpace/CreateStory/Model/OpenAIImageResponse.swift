//
//  OpenAIImageResponse.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 12.08.2024.
//

import Foundation

// MARK: - OpenAIImageResponse

/// `OpenAIImageResponse`, OpenAI'nin görüntü oluşturma API'sinden dönen yanıtı temsil eden bir yapıdır.
/// Bu yapı, `data` dizisini içerir ve her bir eleman bir `ImageData` nesnesini temsil eder.
struct OpenAIImageResponse: Decodable {
    /// API yanıtında dönen görüntü verilerinin listesi. Her bir eleman bir URL içerir.
    let data: [ImageData]
}

// MARK: - ImageData

/// `ImageData`, API tarafından döndürülen bir görüntünün URL'sini temsil eden yapıdır.
struct ImageData: Decodable {
    /// Oluşturulan görüntünün URL'si.
    let url: String
}
