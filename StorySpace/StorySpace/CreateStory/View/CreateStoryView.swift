//
//  CreateStoryView.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 9.08.2024.
//

import SwiftUI

/// `CreateStoryView`, kullanıcıların yeni hikaye oluşturmasını sağlayan bir SwiftUI görünümüdür.
struct CreateStoryView: View {
    /// Hikaye oluşturma sürecini yöneten ViewModel.
    @StateObject private var viewModel = StoryCreationViewModel()
    
    /// Görünümün sunum modunu yöneten ortam değişkeni.
    @Environment(\.presentationMode) var presentationMode
    
    var onDismiss: (() -> Void)?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if viewModel.isLoading {
                        loadingView
                    } else if viewModel.isStoryGenerated {
                        generatedStoryView
                    } else {
                        storyInputFields
                    }
                }
                .navigationTitle("Create New Story")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel", role: .cancel) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text(viewModel.errorMessage ),
                        dismissButton: .default(Text("Ok")) {
                            viewModel.errorMessage = ""
                        }
                    )
                }
            }
        }
    }
    
    /// Hikaye oluşturulurken gösterilen yükleme görünümü.
    private var loadingView: some View {
        VStack {
            Spacer()
            ProgressView {
                VStack {
                    Text("Creating a Story...")
                    Text("This May Take Some Time...")
                }
            }
            .progressViewStyle(CircularProgressViewStyle())
            .padding()
            Spacer()
        }
    }
    
    /// Oluşturulan hikaye ve görüntüleri gösteren görünüm.
    private var generatedStoryView: some View {
        VStack {
            storyAndImageView
            actionButtons
        }
        .padding()
    }
    
    /// Kullanıcının hikaye bilgilerini girdiği alanları içeren görünüm.
    private var storyInputFields: some View {
        VStack(alignment: .leading, spacing: 16) {
            inputField(Strings.themeTitle, example: Strings.exampleTheme, text: $viewModel.theme)
            inputField(Strings.mainCharacterNameTitle, example: Strings.exampleCharacterName, text: $viewModel.mainCharacterName)
            inputField(Strings.mainCharacterTraitsTitle, example: Strings.exampleCharacterTraits, text: $viewModel.mainCharacterTraits)
            inputField(Strings.settingTitle, example: Strings.exampleSetting, text: $viewModel.setting)
            inputField(Strings.specialEventTitle, example: Strings.exampleSpecialEvent, text: $viewModel.specialEvent)
            segmentedPicker(title: Strings.storyTypesTitle, selection: $viewModel.storyType, pickerStyle: .segmented, options: viewModel.storyTypes)
            segmentedPicker(title: Strings.storyLengthTitle, selection: $viewModel.storyLength, pickerStyle: .segmented, options: viewModel.storyLengths)
            segmentedPicker(title: Strings.artStyleTitle, selection: $viewModel.artStyle, pickerStyle: .segmented, options: viewModel.artStyles)
            languagePicker
            segmentedPicker(title: Strings.chatModelTitle, selection: $viewModel.textModel, pickerStyle: .menu, options: viewModel.textModels)
            
            SSButton(text: Strings.createStoryButton, backgroundColor: .colorBlue, textWidth: .infinity) {
                if viewModel.validateFields() {
                    viewModel.createStory()
                    print("Başladı")
                } else {
                    viewModel.errorMessage = Strings.fillAllFieldsError
                    viewModel.showAlert = true
                }
            }
            .padding(.top, 20)
        }
        .padding()
    }
    
    /// Oluşturulan hikaye metni ve görüntüsünü gösteren görünüm.
    private var storyAndImageView: some View {
        VStack {
            TextEditor(text: $viewModel.generatedStory)
                .frame(height: 200)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
            
            SSImage(imageUrl: viewModel.generatedImage, height: 300, width: 300)
        }
    }
    
    /// Yeniden oluşturma ve kaydetme işlemleri için butonları içeren görünüm.
    /// Yeniden oluşturma ve kaydetme işlemleri için butonları içeren görünüm.
    private var actionButtons: some View {
        HStack(spacing: 16) {
            SSButton(text: Strings.recreateButton, backgroundColor: .colorBlue, textWidth: .infinity) {
                viewModel.resetStory()
            }
            SSButton(text: Strings.saveButton, backgroundColor: .colorBlue, textWidth: .infinity, isRequesting: viewModel.buttonState) {
                viewModel.saveStoryToFirebase { success in
                    if success {
                        presentationMode.wrappedValue.dismiss()
                        onDismiss?()
                    }
                }
            }
        }
    }

    
    /// Dil seçim görünümü.
    private var languagePicker: some View {
        VStack(alignment: .leading) {
            Text("Chose Language")
                .font(.headline)
                .foregroundColor(.primary)
            
            Picker("Language", selection: $viewModel.language) {
                ForEach(viewModel.languages, id: \.self) { language in
                    Text(language)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
        }
    }
    
    /// Kullanıcı giriş alanlarını oluşturan yardımcı fonksiyon.
    private func inputField(_ title: String, example: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            TextField(example, text: text)
                .autocorrectionDisabled()
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
        }
    }
    
    /// Segmentli pickerları oluşturan yardımcı fonksiyon.
    private func segmentedPicker<Style: PickerStyle>(title: String, selection: Binding<String>, pickerStyle: Style, options: [String]) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            
            Picker(title, selection: selection) {
                ForEach(options, id: \.self) { option in
                    Text(option)
                }
            }
            .pickerStyle(pickerStyle)
            .padding(.horizontal)
        }
    }
}

#Preview {
    CreateStoryView()
}
