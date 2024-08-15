//
//  ContentView.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 9.08.2024.
//

import SwiftUI

/// `MainView`, uygulamanın başlangıç ekranını belirleyen bir SwiftUI görünümüdür.
/// Kullanıcı oturum açmışsa ana sekme çubuğunu gösterir, aksi halde karşılama ekranını gösterir.
struct MainView: View {
    /// Kullanıcının oturum açma durumunu yöneten ViewModel.
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            /// Kullanıcı oturum açmışsa, ana uygulama sekme çubuğunu gösterir.
            TabbarView()
        } else {
            /// Kullanıcı oturum açmamışsa, karşılama ekranını gösterir.
            WelcomeView()
        }
    }
}

#Preview {
    MainView()
}
