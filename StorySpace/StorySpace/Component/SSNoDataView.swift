//
//  SSNoDataView.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 12.08.2024.
//

import SwiftUI

/// `SSNoDataView`, veri bulunamadığında gösterilecek bir bilgi ekranı sunan basit bir SwiftUI bileşenidir.
/// Bu bileşen, kullanıcıya herhangi bir hikaye bulunamadığında bir görsel ve bilgi mesajı gösterir.
struct SSNoDataView: View {
    var body: some View {
        VStack {
            Image("nodata")
                .resizable()
                .renderingMode(.template)
                .frame(width: 200, height: 200)
            
            Text("Story Not Found")
                .font(.title2)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    SSNoDataView()
}
