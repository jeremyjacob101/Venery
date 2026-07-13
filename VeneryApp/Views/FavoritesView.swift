import SwiftUI

struct FavoritesView: View {
    let animals: [AnimalEntry]
    let favorites: FavoritesStore

    private var favoriteAnimals: [AnimalEntry] {
        animals.filter { favorites.contains($0) }
    }

    var body: some View {
        Group {
            if favoriteAnimals.isEmpty {
                ContentUnavailableView(
                    "No favorites yet",
                    systemImage: "heart",
                    description: Text("Save an animal from today or from the full list to keep it here.")
                )
            } else {
                List(favoriteAnimals) { entry in
                    HStack(spacing: 12) {
                        NavigationLink {
                            AnimalDetailView(entry: entry, favorites: favorites)
                        } label: {
                            AnimalRow(entry: entry)
                        }

                        FavoriteButton(entry: entry, favorites: favorites)
                    }
                    .padding(.vertical, 5)
                    .listRowBackground(Color.appBackground)
                }
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
            }
        }
        .background(Color.appBackground.ignoresSafeArea())
        .navigationTitle("Favorites")
        .toolbarBackground(Color.appBackground, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}
