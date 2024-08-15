//
//  ThemeChangeView.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 10.08.2024.
//

import SwiftUI

/// `ThemeChangeView` yapısı, kullanıcıların uygulamanın temasını değiştirmesine olanak tanır.
///
/// Bu görünüm, kullanıcıya farklı tema seçeneklerini sunar ve seçilen temaya göre kullanıcı arayüzünü günceller.
struct ThemeChangeView: View {
    /// Tema değişikliklerini yöneten ViewModel.
    @ObservedObject private var viewModel: ThemeChangeViewModel
    
    /// Geçerli renk şeması.
    private let scheme: ColorScheme
    
    /// Animasyonları yönetmek için kullanılan `Namespace`.
    @Namespace private var animation
    
    /// Belirli bir renk şeması ile `ThemeChangeView`'i başlatır.
    ///
    /// - Parameter scheme: Geçerli renk şeması.
    init(scheme: ColorScheme) {
        self.scheme = scheme
        self._viewModel = ObservedObject(wrappedValue: ThemeChangeViewModel(scheme: scheme))
    }
    
    var body: some View {
        VStack {
            /// Kullanıcının seçtiği temaya göre dolu bir daire.
            Circle()
                .fill(viewModel.userTheme.color(scheme).gradient)
                .frame(width: 150, height: 150)
                .mask {
                    Rectangle()
                        .overlay {
                            Circle()
                                .offset(viewModel.circleOffset)
                                .blendMode(.destinationOut)
                        }
                }
            
            Text("Choose a Style")
                .font(.title2.bold())
                .padding(.top, 25)
            
            Text("Pop or subtle, Day or night.\nCustomize your interface.")
                .multilineTextAlignment(.center)
            
            HStack(spacing: 0) {
                ForEach(Theme.allCases, id: \.rawValue) { theme in
                    Text(theme.rawValue)
                        .padding(.vertical, 10)
                        .frame(width: 100)
                        .background {
                            ZStack {
                                if viewModel.userTheme == theme {
                                    Capsule()
                                        .fill(Color.green)
                                        .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                                }
                            }
                            .animation(.snappy, value: viewModel.userTheme)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.changeTheme(to: theme)

                        }
                }
            }
            .padding(3)
            .background(Color.primary.opacity(0.06), in: Capsule())
            .padding(.top, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(height: 410)
        .background(Color.themeBG)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .padding(.horizontal, 15)
        .environment(\.colorScheme, scheme)

    }
}

#Preview {
    ThemeChangeView(scheme: .dark)
}


