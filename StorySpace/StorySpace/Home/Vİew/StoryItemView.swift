//
//  StoryItemView.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 11.08.2024.
//

import SwiftUI
import SDWebImageSwiftUI

/// `StoryItemView`, bir hikayeyi liste görünümünde gösteren SwiftUI bileşenidir.
struct StoryItemView: View {
    
    /// Görüntülenecek hikaye.
    var story: Story
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            /// Hikayeye ait görseli gösterir.
            SSImage(imageUrl: story.imageUrl, height: 130, width: 130)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
            /// Hikaye başlığını gösterir.
            VStack(alignment: .leading) {
                Text(story.title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
            }
            .padding(.bottom, 16)
            .padding(.horizontal, 8)
        }
        .background(Color.lighterGrey)
        .contentShape(.contextMenuPreview, RoundedRectangle(cornerRadius: 25))
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
    }
}

#Preview {
    StoryItemView(story: Story(id: "",
                               title: "Allahtan",
                               imageUrl: "https://firebasestorage.googleapis.com:443/v0/b/storyspace-1ad2f.appspot.com/o/story_images%2FIUMRvqxPYW3IdmRQgGyb.jpg?alt=media&token=af063c0a-0d42-4d17-a417-83e1690adf7e",
                               content: "DEniyoruz",
                               timeStamp: 1700025126.510, storyType: "Macera"))
}
