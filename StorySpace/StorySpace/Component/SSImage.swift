//
//  SSImage.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 11.08.2024.
//

import SwiftUI
import SDWebImageSwiftUI

/// `SSImage`, uzaktan bir görüntüyü yükleyen ve gösteren bir SwiftUI bileşenidir.
/// Eğer görüntü yüklenemezse, varsayılan bir simge gösterilir.
struct SSImage: View {
    /// Gösterilecek görüntünün URL'si.
    var imageUrl: String
    
    /// Görüntünün yüksekliği.
    var height: CGFloat
    
    /// Görüntünün genişliği.
    var width: CGFloat
    
    /// Görüntü başarıyla yüklendiğinde çalışacak opsiyonel bir işlem.
    var onSuccess: ((UIImage?) -> Void)?
    
    var body: some View {
        if let url = URL(string: imageUrl) {
            WebImage(url: url) { image in
                    image.resizable() // Control layout like SwiftUI.AsyncImage, you must use this modifier or the view will use the image bitmap size
                } placeholder: {
                        Rectangle().foregroundColor(.gray)
                }
                // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
                .onSuccess { image, data, cacheType in
                    onSuccess?(image)
                }
                .indicator(.activity) // Activity Indicator
                .transition(.fade(duration: 0.5)) // Fade Transition with duration
                .scaledToFit()
                .frame(width: width, height: height)
        
            
        } else {
            Image(systemName: "book.fill")
                .resizable()
                .scaledToFit()
                .frame(width: width, height: height)
        }
    }
}

#Preview {
    SSImage(imageUrl: "", height: 21, width: 12)
}
