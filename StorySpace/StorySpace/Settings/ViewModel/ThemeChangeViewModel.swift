//
//  ThemeChangeViewModel.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 10.08.2024.
//


import SwiftUI

/// `ThemeChangeViewModel` sınıfı, uygulamanın temasını değiştirmek için kullanılan ViewModel'dir.
///
/// Bu sınıf, tema değişikliklerini yönetir ve tema değişikliklerine bağlı animasyonları kontrol eder.
class ThemeChangeViewModel: ObservableObject {
    /// Kullanıcının tema tercihi.
    @AppStorage("userTheme") var userTheme: Theme = .systemDefault
    
    /// Temanın değişimine bağlı animasyonları yönetmek için kullanılan `Namespace`.
    @Namespace private var animation
    
    /// Tema değişikliğine bağlı olarak kullanılan dairenin konumu.
    @Published var circleOffset: CGSize
    
    /// Belirli bir renk şemasına göre ViewModel'i başlatır.
    ///
    /// - Parameter scheme: Geçerli renk şeması.
    init(scheme: ColorScheme) {
        let isDark = scheme == .dark
        self.circleOffset = CGSize(width: isDark ? 30 : 150, height: isDark ? -25 : -150)
    }
    /// Uygulamanın temasını değiştirir.
    ///
    /// - Parameter theme: Yeni tema.
    func changeTheme(to theme: Theme) {
        userTheme = theme
    }
}
