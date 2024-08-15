//
//  TabbarView.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 9.08.2024.
//

import SwiftUI

/// `TabbarView`, uygulamanın ana navigasyonunu sağlayan bir tab bar görünümüdür.
/// Bu görünüm, kullanıcıların farklı bölümler arasında geçiş yapmasını sağlar.
struct TabbarView: View {
    var body: some View {
        TabView {
            /// Ana ekran görünümü.
            HomeView()
                .tabItem {
                    Image(systemName: "book")
                    Text("Story")
                }
                .tag(1)
            
            /// Ayarlar ekranı görünümü.
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(2)
        }
    }
}

#Preview {
    TabbarView()
}
