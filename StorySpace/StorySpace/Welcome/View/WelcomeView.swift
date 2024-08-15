//
//  Login.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 9.08.2024.
//

import SwiftUI

/// `WelcomeView`, kullanıcının giriş yapmasını veya yeni bir hesap oluşturmasını sağlayan bir SwiftUI görünümüdür.
struct WelcomeView: View {
    /// Giriş ve kayıt işlemlerini yöneten ViewModel.
    @StateObject var viewModel = WelcomeViewModel()
    
    var body: some View {
        VStack {
            logoView
            toggleButtons
            contentBasedOnIndex
            Spacer()
        }
        .ignoresSafeArea(.keyboard)
    }
    
    /// Uygulamanın logosunu ve başlığını gösteren görünüm.
    private var logoView: some View {
        VStack {
            Image("story_space_icon")
                .resizable()
                .frame(width: 200, height: 200)
            Text("StorySpace")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.colorBlack)
        }
    }
    
    /// Giriş ve kayıt ekranları arasında geçiş yapmayı sağlayan butonlar.
    private var toggleButtons: some View {
        HStack {
            toggleButton(title: Strings.accountExistTitle, indexValue: 0)
            toggleButton(title: Strings.createAccountTitle, indexValue: 1)
        }
        .background(Color.gray.opacity(0.5))
        .clipShape(Capsule())
        .padding(.top, 25)
    }
    
    /// Giriş ve kayıt ekranları arasında geçiş yapmayı sağlayan butonları oluşturan yardımcı fonksiyon.
    private func toggleButton(title: String, indexValue: Int) -> some View {
        Button(action: {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)) {
                viewModel.index = indexValue
            }
        }) {
            Text(title)
                .foregroundColor(viewModel.index == indexValue ? .white : .colorGrey)
                .fontWeight(.bold)
                .padding(.vertical, 10)
                .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                .background(viewModel.index == indexValue ? Color.colorBlue : Color.clear)
                .clipShape(Capsule())
        }
    }
    
    /// Kullanıcının seçimine göre giriş veya kayıt formunu gösteren içerik.
    @ViewBuilder
    private var contentBasedOnIndex: some View {
        if viewModel.index == 0 {
            loginView
        } else {
            registerView
        }
    }
    
    /// Giriş formunu gösteren görünüm.
    private var loginView: some View {
        VStack {
            emailField
                .padding()
            passwordField
                .padding()
            errorMessageView
            SSButton(text: Strings.login, backgroundColor: .colorBlue, textWidth: .infinity,isRequesting:viewModel.buttonState) {
                viewModel.login()
            }
            .padding()
        }
    }
    
    /// Kayıt formunu gösteren görünüm.
    private var registerView: some View {
        VStack {
            usernameField
                .padding()
            emailField
                .padding()
            passwordField
                .padding()
            errorMessageView
            SSButton(text: Strings.register, backgroundColor: .colorBlue,textWidth: .infinity, isRequesting:viewModel.buttonState) {
                viewModel.register()
            }
            .padding()
        }
    }
    
    /// Hata mesajını gösteren görünüm.
    @ViewBuilder
    private var errorMessageView: some View {
        if !viewModel.errorMessage.isEmpty {
            Text(viewModel.errorMessage)
                .foregroundColor(.red)
                .padding(.top, 10)
        }
    }
    
    /// Kullanıcı adı giriş alanını gösteren görünüm.
    private var usernameField: some View {
        HStack {
            Image(systemName: "person")
            TextField("Username", text: $viewModel.name)
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled()
                .submitLabel(.next)
        }
    }
    
    /// E-posta adresi giriş alanını gösteren görünüm.
    private var emailField: some View {
        HStack {
            Image(systemName: "envelope")
            TextField("Email address", text: $viewModel.email)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .submitLabel(.next)
        }
    }
    
    /// Şifre giriş alanını gösteren görünüm.
    private var passwordField: some View {
        HStack {
            Image(systemName: "lock.rectangle")
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)
                .submitLabel(.done)
        }
    }
}

#Preview {
    WelcomeView()
}
