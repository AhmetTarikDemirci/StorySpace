//
//  Strings.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 14.08.2024.
//

import Foundation
/// StorySpace uygulamasında kullanılan tüm yerelleştirilmiş stringleri içeren bir yapı.
struct Strings {
    
    static let adventureKey = "adventureKey"
    static let romanticKey = "romanticKey"
    static let scienceFictionKey = "scienceFictionKey"
    static let fearKey = "fearKey"
    
    // MARK: - Story Types
    static let adventure = NSLocalizedString(adventureKey, comment: "Adventure story type")
    static let romantic = NSLocalizedString(romanticKey, comment: "Romantic story type")
    static let scienceFiction = NSLocalizedString(scienceFictionKey, comment: "Science fiction story type")
    static let fear = NSLocalizedString(fearKey, comment: "Horror story type")
    
    // MARK: - Hikaye Uzunlukları
    static let short = NSLocalizedString("Short", comment: "Short story length")
    static let medium = NSLocalizedString("Medium", comment: "Medium story length")
    static let long = NSLocalizedString("Long", comment: "Long story length")
    
    // MARK: - Diller
    static let turkish = NSLocalizedString("Turkish", comment: "Turkish language")
    static let english = NSLocalizedString("English", comment: "English language")
    
    // MARK: - Sanat Tarzları
    static let realistic = NSLocalizedString("Realistic", comment: "Realistic art style")
    static let cartoon = NSLocalizedString("Cartoon", comment: "Cartoon art style")
    static let oilPainting = NSLocalizedString("Oil Painting", comment: "Oil painting art style")
    static let abstract = NSLocalizedString("Abstract", comment: "Abstract art style")
    
    // MARK: - Placeholderlar
    static let exampleTheme = NSLocalizedString("For example, 'Space Travel'", comment: "Example for theme")
    static let exampleCharacterName = NSLocalizedString("For example, 'Luna'", comment: "Example for character name")
    static let exampleCharacterTraits = NSLocalizedString("For example, 'Brave, curious, young wizard'", comment: "Example for character traits")
    static let exampleSetting = NSLocalizedString("For example, 'Ancient Forest'", comment: "Example for setting")
    static let exampleSpecialEvent = NSLocalizedString("For example, 'Luna discovers a spell to control time'", comment: "Example for special event")
    
    // MARK: - Başlıklar
    static let themeTitle = NSLocalizedString("Theme", comment: "Title for theme")
    static let mainCharacterNameTitle = NSLocalizedString("Main Character Name", comment: "Title for main character name")
    static let mainCharacterTraitsTitle = NSLocalizedString("Main Character Traits", comment: "Title for main character traits")
    static let settingTitle = NSLocalizedString("Setting", comment: "Title for setting")
    static let specialEventTitle = NSLocalizedString("Special Event", comment: "Title for special event")
    static let storyTypesTitle = NSLocalizedString("Story Type", comment: "Title for story types")
    static let storyLengthTitle = NSLocalizedString("Story Length", comment: "Title for story length")
    static let artStyleTitle = NSLocalizedString("Art Style", comment: "Title for art style")
    static let chatModelTitle = NSLocalizedString("Chat Model", comment: "Title for chat model")
    
    // MARK: - Butonlar
    static let recreateButton = NSLocalizedString("Recreate", comment: "Button text for recreating the story")
    static let saveButton = NSLocalizedString("Save", comment: "Button text for saving the story")
    static let createStoryButton = NSLocalizedString("Create Story", comment: "Button text for creating a story")
    static let register = NSLocalizedString("Register", comment: "")
    static let login = NSLocalizedString("Login", comment: "")
    static let accountExistTitle = NSLocalizedString("I Have an Account", comment: "")
    static let createAccountTitle = NSLocalizedString("Create Account", comment: "")
    static let newStoryButton = NSLocalizedString("Create New Story", comment: "")
    
    // MARK: - Hata Mesajları
    static let fillAllFieldsError = NSLocalizedString("Please fill in all the fields.", comment: "Error message when not all fields are filled")
    static let enterValidEmail = NSLocalizedString("Please enter a valid email address", comment: "")
    static let mandatoryFieldsMissing = NSLocalizedString("Mandatory fields are missing", comment: "")
    static let checkEmailAddress = NSLocalizedString("Please check your email address", comment: "")
    static let passwordTooShort = NSLocalizedString("Your password must be at least 6 characters long", comment: "")
    static let userNotLoggedIn = NSLocalizedString("user_not_logged_in", comment: "Kullanıcı giriş yapmamış")
    static let storyNotFound = NSLocalizedString("story_not_found", comment: "Hikaye bulunamadı")
    static let noTitle = NSLocalizedString("no_title", comment: "Başlık Yok")
    static let noContent = NSLocalizedString("no_content", comment: "İçerik Yok")
    static let unknownType = NSLocalizedString("unknown_type", comment: "Bilinmeyen Tür")
    static let errorDeletingStory = NSLocalizedString("error_deleting_story", comment: "Hikaye silinirken hata")
    static let invalidImageURL = NSLocalizedString("error_invalid_image_url", comment: "Invalid image URL")
    static let downloadImageFailed = NSLocalizedString("error_download_image_failed", comment: "Failed to download image")
    static let uploadImageFailed = NSLocalizedString("error_upload_image_failed", comment: "Failed to upload image")
    static let imageURLFetchFailed = NSLocalizedString("error_image_url_fetch_failed", comment: "Failed to fetch image URL")
    static let imageNotFound = NSLocalizedString("error_image_not_found", comment: "Image not found")
    static let saveStoryFailed = NSLocalizedString("error_save_story_failed", comment: "Failed to save story")
    static let noResponse = NSLocalizedString("error_no_response", comment: "No response")
       static let errorUserNotLoggedIn = NSLocalizedString("User is not logged in.", comment: "Error message when the user is not logged in")
       static let errorUserNotFound = NSLocalizedString("User not found.", comment: "Error message when the user is not found")
       static let errorValidation = NSLocalizedString("Please fill in all fields.", comment: "Error message when validation fails")
       static let errorReauthenticationFailed = NSLocalizedString("Reauthentication failed: ", comment: "Error message when reauthentication fails")
       static let errorUpdatePasswordFailed = NSLocalizedString("Failed to update password: ", comment: "Error message when password update fails")
       static let errorUpdateEmailFailed = NSLocalizedString("Failed to update email: ", comment: "Error message when email update fails")
       static let errorUpdateProfileFailed = NSLocalizedString("Failed to update profile: ", comment: "Error message when profile update fails")
       static let errorDatabaseUpdateFailed = NSLocalizedString("Failed to update database: ", comment: "Error message when database update fails")

    // MARK: - Başarı Mesajları
       static let successPasswordUpdated = NSLocalizedString("Password updated successfully.", comment: "Success message when the password is updated")
       static let successProfileUpdated = NSLocalizedString("Profile updated successfully.", comment: "Success message when the profile is updated")
    
    // MARK: - Diğer
    static let loadingMessage = NSLocalizedString("Loading...", comment: "Loading message")
    static let storyTypes = [adventure,romantic,scienceFiction,fear]
    static let storyLengths = [short,medium,long]
    static let languages = [turkish,english]
    static let artStyles = [realistic,cartoon,oilPainting,abstract]
    
    static let textModels = [
        NSLocalizedString("gpt-4o", comment: ""),
        NSLocalizedString("gpt-4o-mini", comment: ""),
        NSLocalizedString("gpt-4-turbo", comment: ""),
        NSLocalizedString("gpt-4", comment: ""),
        NSLocalizedString("gpt-3.5-turbo-0125", comment: ""),
        NSLocalizedString("gpt-3.5-turbo", comment: "")
    ]
    

}
