//
//  EditProfile.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 14.08.2024.
//

import SwiftUI

/// Kullanıcının profil bilgilerini ve şifresini güncellemesi için kullanılan SwiftUI görünümü.
/// Bu görünüm, kullanıcıya adını, e-posta adresini ve şifresini güncelleme imkanı sunar.
/// Güncelleme işlemi sırasında yüklenme durumu ve hata veya başarı mesajları gösterilir.
struct EditProfile: View {
    /// Profil düzenleme işlemlerini yöneten ViewModel.
    @StateObject var viewModel = EditProfileViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                // Güncelleme işlemi devam ediyorsa yüklenme göstergesi gösterilir.
                ProgressView()
            } else {
                // Güncelleme işlemi tamamlandığında form gösterilir.
                Form {
                    Section(header: Text("User Information")) {
                        // Kullanıcı adı ve e-posta adresi alanları.
                        TextField("Username", text: $viewModel.name)
                        TextField("Email", text: $viewModel.email)
                            .keyboardType(.emailAddress)
                    }
                    
                    Section(header: Text("Update Password")) {
                        // Kullanıcı mevcut ve yeni şifresini girebilir.
                        SecureField("Current Password", text: $viewModel.currentPassword)
                        SecureField("New Password", text: $viewModel.newPassword)
                    }
                    
                    // Başarı mesajı gösterilir.
                    if let successMessage = viewModel.successMessage {
                        Text(successMessage)
                            .foregroundColor(.green)
                    }
                    
                    // Hata mesajı gösterilir.
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                    
                    // Güncelleme işlemini başlatan buton.
                    Button("Update") {
                        viewModel.updateProfile()
                    }
                }
                .navigationTitle("Edit Profile")
            }
        }
    }
}

#Preview {
    EditProfile(viewModel: EditProfileViewModel())
}
