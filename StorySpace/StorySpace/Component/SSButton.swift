//
//  SSButton.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 9.08.2024.
//

import SwiftUI

/// `SSButton` yapısı, özelleştirilebilir bir buton bileşeni sunar.
///
/// Bu yapı, buton metni, arka plan rengi, buton durumu ve diğer özellikler ile birlikte bir buton oluşturur.
///
/// ### Kullanım Örneği
/// ```
/// struct ContentView: View {
///     var body: some View {
///         SSButton(
///             text: "Giriş Yap",
///             backgroundColor: Color.blue,
///             isRequesting: false
///         ) {
///             print("Butona tıklandı")
///         }
///     }
/// }
/// ```
///
/// - Parameters:
///   - text: Buton metni.
///   - textColor: Buton metninin rengi. Varsayılan değer `.colorAlwaysWhite`.
///   - backgroundColor: Butonun arka plan rengi.
///   - textWidth: Buton metninin genişliği. Varsayılan değer `nil`.
///   - isRequesting: İstek gönderilip gönderilmediğini belirten durum. Varsayılan değer `false`.
///   - borderColor: Butonun kenar çizgisi rengi. Varsayılan değer `.lighterGrey`.
///   - action: Buton tıklandığında çalışacak eylem.
struct SSButton: View {
    /// Buton metni.
    var text: String
    
    /// Buton metninin rengi (varsayılan: `.colorAlwaysWhite`).
    var textColor: Color? = .colorAlwaysWhite
    
    /// Butonun arka plan rengi.
    var backgroundColor: Color
    
    /// Buton metninin genişliği (varsayılan: `nil`).
    var textWidth: CGFloat? = nil
    
    /// İstek gönderilip gönderilmediğini belirten durum (varsayılan: `false`).
    var isRequesting: Bool = false
    
    /// Butonun kenar çizgisi rengi (varsayılan: `.lighterGrey`).
    var borderColor: Color? = .lighterGrey
    
    /// Buton tıklandığında çalışacak eylem.
    var action: () -> Void
    
    /// Buton metni için etkili renk.
    private var effectiveTextColor: Color {
        textColor ?? .colorAlwaysWhite
    }
    
    /// Buton kenar çizgisi için etkili renk.
    private var effectiveBorderColor: Color {
        borderColor ?? .lighterGrey
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                if isRequesting {
                    ProgressView()
                } else {
                    Text(text)
                        .font(.body.weight(.semibold))
                        .foregroundColor(effectiveTextColor)
                }
            }
            .padding(.horizontal, 20)
            .frame(height: 36)
            .frame(maxWidth: textWidth)
            .background(backgroundColor)
            .foregroundColor(backgroundColor)
            .cornerRadius(15)
          
        }
        .disabled(isRequesting)
    }
}

#Preview {
    SSButton(
        text: "Giriş Yap",
        backgroundColor: Color.colorMain,
        isRequesting: false
    ) { }
}
