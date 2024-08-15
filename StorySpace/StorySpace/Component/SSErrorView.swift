//
//  SSErrorView.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 12.08.2024.
//

import SwiftUI

/// `SSErrorView`, bir hata mesajını kullanıcıya gösteren ve yeniden deneme butonu sunan bir SwiftUI bileşenidir.
/// Bu bileşen, kullanıcıya veri yüklenirken bir hata oluştuğunda uygun bir geri bildirim sağlar.
struct SSErrorView: View {
    /// Gösterilecek hata mesajı.
    var error: String
    
    /// Yeniden deneme butonuna tıklandığında çalışacak eylem.
    var action: () -> Void
    
    var body: some View {
        VStack {
            Text("Error loading stories: \(error)")
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding()
            
            Button("Try Again") {
                action()
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    SSErrorView(error: "Ağ bağlantısı kesildi") {
        // Yeniden deneme eylemi
    }
}
