//
//  SettingsView.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 9.08.2024.
//

import SwiftUI
import FirebaseAuth

/// `SettingsView` yapısı, kullanıcı ayarlarını yönetmek için kullanılan bir görünüm sağlar.
///
/// Bu görünüm, profil düzenleme, tema değiştirme, hesap silme ve çıkış yapma gibi işlemleri içerir.
struct SettingsView: View {
    /// Ayarları yöneten ViewModel.
    @StateObject var viewModel = SettingsViewViewModel()
    
    /// Geçerli renk şeması, cihazın renk temasını belirler.
    @Environment(\.colorScheme) private var scheme
   
    var body: some View {
        NavigationView {
            Form {
                profileSection
                settingsSection
                NavigationLink("Privacy Policy", destination: PrivacyPolicyView())
                logoutSection
            }
            .navigationBarTitle("Settings")
            .preferredColorScheme(viewModel.userTheme.colorScheme)
        }
        .onAppear {
            viewModel.fetchUser() // Kullanıcı bilgilerini yükler
        }
        .sheet(isPresented: $viewModel.changeTheme) {
            ThemeChangeView(scheme: scheme)
                .presentationDetents([.height(410)])
                .presentationBackground(.clear)
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Are You Sure You Want to Delete the Account?"),
                message: Text("This process cannot be undone."),
                primaryButton: .destructive(Text("Yes")) {
                    viewModel.deleteAccount { result in
                        switch result {
                        case .success:
                            print("Hesap silindi")
                        case .failure(let error):
                            print("Hesap silme başarısız: \(error.localizedDescription)")
                        }
                    }
                },
                secondaryButton: .cancel(Text("No"))
            )
        }
    }
    
    /// Profil bölümünü oluşturur.
    private var profileSection: some View {
        Group {
            HStack {
                Spacer()
                VStack {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                    Text(viewModel.user?.email ?? "")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }.background {
                NavigationLink("") {
                    EditProfile()
                }
            }
        }
    }
    
    /// Ayarlar bölümünü oluşturur.
    private var settingsSection: some View {
        Section("Apperance") {
            HStack {
                Button {
                    viewModel.toggleTheme()
                } label: {
                    Text("Change Theme")
                }
            }
        }
    }
    
    /// Çıkış ve hesap silme bölümünü oluşturur.
    private var logoutSection: some View {
        Section {
            Button {
                viewModel.showAlert = true
            } label: {
                Text("Permanently Delete Account")
                    .foregroundColor(.red)
            }
            
            Button {
                viewModel.logout()
            } label: {
                Text("Logout")
                    .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    SettingsView()
}
