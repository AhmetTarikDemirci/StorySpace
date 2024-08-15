//
//  webView.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 12.08.2024.
//

import Foundation
import SwiftUI
import WebKit

/// `WebView`, SwiftUI içerisinde bir web sayfası görüntülemek için kullanılan bir bileşendir.
/// `UIViewRepresentable` protokolünü uygulayarak `WKWebView`'i SwiftUI görünümüne entegre eder.
struct WebView: UIViewRepresentable {
    /// Yüklenecek web sayfasının URL'si.
    let url: URL

    /// `WKWebView` oluşturur ve geri döner.
    /// - Parameter context: Görünüm bağlamı.
    /// - Returns: Yeni bir `WKWebView` örneği.
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    /// `WKWebView`'i günceller ve belirli bir URL'yi yükler.
    /// - Parameters:
    ///   - webView: Güncellenmesi gereken `WKWebView` örneği.
    ///   - context: Görünüm bağlamı.
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
