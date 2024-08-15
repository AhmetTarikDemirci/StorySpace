//
//  PrivacyPolicyView.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 12.08.2024.
//

import SwiftUI

/// `PrivacyPolicyView`, kullanıcıya uygulamanın gizlilik politikasını göstermek için kullanılan bir SwiftUI görünümüdür.
struct PrivacyPolicyView: View {
    var body: some View {
        NavigationView {
            /// WebView bileşeni, belirtilen URL'yi yükleyerek gizlilik politikası sayfasını gösterir.
            WebView(url: URL(string: "https://ahmettarikdemirci.io/story_space/PrivacyPolicy.html")!)
                .navigationTitle("Privacy Policy")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

