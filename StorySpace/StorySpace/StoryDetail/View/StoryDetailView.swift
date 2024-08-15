import SwiftUI
import SDWebImageSwiftUI

/// `StoryDetailView`, bir hikayenin detaylarını göstermek için kullanılan SwiftUI görünümüdür.
struct StoryDetailView: View {
    /// Görüntülenecek hikaye modeli.
    var story: Story
    
    var body: some View {
        VStack {
            /// Hikaye görseli, belirli bir yükseklik ve genişlikte görüntülenir.
            /// - Parameters:
            ///   - imageUrl: Görüntülenecek resmin URL'si.
            ///   - height: Resmin yüksekliği (300 piksel olarak ayarlanmış).
            ///   - width: Resmin genişliği (ekran genişliğine göre ayarlanmış).
            SSImage(imageUrl: story.imageUrl, height: 300, width: UIScreen.main.bounds.width)
            
            /// Hikaye başlığı, büyük bir yazı tipi ve kalın font ile gösterilir.
            Text(story.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            /// Hikaye metni, kaydırılabilir bir alan içinde gösterilir.
            ScrollView {
                Text(story.content)
                    .padding()
                    .textSelection(.enabled) // Kullanıcıların metni seçmesine olanak tanır.
            }
            
            /// Kullanıcıların hikayeyi paylaşmasına olanak tanıyan paylaşım butonu.
            ShareLink(items: [story.content,  story.imageUrl ]) {
                Text("Share the Story")
                    .padding(.horizontal, 20)
                    .frame(height: 36)
                    .background(Color.colorMain)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
            .padding(.bottom, 20)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    StoryDetailView(story: Story(id: "", title: "Deneme", imageUrl: "", content: "", timeStamp: 178446648694.5, storyType: "Macera"))
}
