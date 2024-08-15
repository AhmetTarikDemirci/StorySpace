//
//  BaseViewModel.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 14.08.2024.
//

import Foundation

class BaseViewModel : ObservableObject {
    
    @Published var errorMessage: String = ""
    
    @Published  var buttonState: Bool = false
    
    @Published var isLoading: Bool = false
}
