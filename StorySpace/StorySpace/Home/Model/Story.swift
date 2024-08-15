//
//  Story.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 10.08.2024.
//

import Foundation

/// `Story`, kullanıcının oluşturduğu bir hikayeyi temsil eden bir veri modelidir.
/// Bu yapı, hikayenin ID'sini, başlığını, içeriğini, oluşturulma zamanını ve türünü içerir.
struct Story: Identifiable {
    /// Hikayenin benzersiz kimliği.
    var id: String
    
    /// Hikayenin başlığı.
    var title: String
    
    /// Hikayeye ait görselin URL'si.
    var imageUrl: String
    
    /// Hikayenin metin içeriği.
    var content: String
    
    /// Hikayenin oluşturulma zamanını temsil eden zaman damgası.
    var timeStamp: TimeInterval
    
    /// Hikayenin türü, örneğin "Macera", "Romantik" vb.
    var storyType: String
}
