//
//  Extensions.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 9.08.2024.
//

import Foundation

/// `Encodable` protokolünü uygulayan tüm türler için bir uzantı.
/// Bu uzantı, bir nesneyi sözlüğe (`Dictionary`) dönüştürmek için kullanılır.
extension Encodable {
    
    /// Nesneyi bir sözlük (`Dictionary`) olarak döndürür.
    /// - Returns: Başarılı olursa nesnenin sözlük olarak döndürülmüş hali, aksi takdirde boş bir sözlük döner.
    func asDictionary() -> [String: Any] {
        // Nesneyi JSON verisi olarak kodlar.
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        
        do {
            // JSON verisini bir sözlüğe dönüştürür.
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
        } catch {
            return [:]
        }
    }
}
