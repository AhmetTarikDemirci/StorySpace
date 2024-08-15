//
//  Theme.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 10.08.2024.
//

import Foundation
import SwiftUI

/// `Theme` enum'u, uygulamanın desteklediği tema türlerini tanımlar.
///
/// Bu enum, sistem varsayılanı, açık ve koyu tema seçeneklerini içerir.
enum Theme: String, CaseIterable {
    /// Sistem varsayılanı teması.
    case systemDefault = "Default"
    
    /// Açık tema.
    case light = "Light"
    
    /// Koyu tema.
    case dark = "Dark"
    
    /// Belirli bir renk şemasına göre temanın rengini döndürür.
    ///
    /// - Parameter scheme: Geçerli renk şeması.
    /// - Returns: Temanın rengi.
    func color(_ scheme: ColorScheme) -> Color {
        switch self {
        case .systemDefault:
            return scheme == .dark ? .blue : .orange
        case .light:
            return .orange
        case .dark:
            return .blue
        }
    }
    
    /// Temanın renk şemasını döndürür.
    var colorScheme: ColorScheme? {
        switch self {
        case .systemDefault:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
