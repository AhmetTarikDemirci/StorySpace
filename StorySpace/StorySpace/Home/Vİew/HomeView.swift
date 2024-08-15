//
//  HomeView.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 9.08.2024.
//

import SwiftUI
import Firebase

/// `HomeView`, kullanıcının oluşturduğu hikayeleri gösteren ana ekran görünümüdür.
struct HomeView: View {
    /// Yeni hikaye oluşturma görünümünün gösterilip gösterilmeyeceğini belirten durum.
    @State private var isShowCreateView = false
    
    /// Ana ekran verilerini yöneten ViewModel.
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Stories are loading...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if !viewModel.errorMessage.isEmpty {
                    SSErrorView(error: viewModel.errorMessage) {
                        viewModel.fetchStories()
                    }
                } else if viewModel.stories.isEmpty {
                    SSNoDataView()
                } else {
                    storyListView
                }

                createStoryButton
                    .padding(.bottom, 20)
                    .padding(.horizontal, 15)
            }
            .navigationTitle("Stories")
            .sheet(isPresented: $isShowCreateView) {
                CreateStoryView(onDismiss: {
                    viewModel.fetchStories() // Veri güncellemesi yapılıyor
                })
            }
            .onAppear {
                viewModel.fetchStories()
            }
        }
    }

    /// Kullanıcının oluşturduğu hikayelerin listesini gösteren görünüm.
    private var storyListView: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(viewModel.groupedStories.keys.sorted(), id: \.self) { storyType in
                    VStack(alignment: .leading) {
                        Text(storyType)
                            .font(.headline)
                            .padding(.leading)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 15) {
                                ForEach(viewModel.groupedStories[storyType] ?? []) { story in
                                    NavigationLink(destination: StoryDetailView(story: story)) {
                                        StoryItemView(story: story)
                                            .contextMenu {
                                                Button(role: .destructive) {
                                                    viewModel.deleteStory(story)
                                                } label: {
                                                    Label("Delete", systemImage: "trash")
                                                }
                                            }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
        }
    }

    /// Yeni hikaye oluşturma butonunu gösteren görünüm.
    private var createStoryButton: some View {
        SSButton(text: Strings.newStoryButton, backgroundColor: .colorBlue, textWidth: .infinity) {
            isShowCreateView = true
        }
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
