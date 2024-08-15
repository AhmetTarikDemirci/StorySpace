//
//  StorySpaceApp.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 9.08.2024.
//

import SwiftUI
import FirebaseCore

@main
struct StorySpaceApp: App {
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    init() {
        FirebaseApp.configure()
    }
  var body: some Scene {
    WindowGroup {
      NavigationView {
        MainView()
              .preferredColorScheme(userTheme.colorScheme)
      }
    }
  }
}
