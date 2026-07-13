import SwiftUI

struct FavoriteButton: View {
    let entry: AnimalEntry
    let favorites: FavoritesStore
    var prominent = false

    private var isFavorite: Bool {
        favorites.contains(entry)
    }

    var body: some View {
        Button {
            favorites.toggle(entry)
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .font(prominent ? .title3.weight(.semibold) : .body.weight(.semibold))
                .foregroundStyle(isFavorite ? Color.coral : (prominent ? Color.white : Color.appInk))
                .frame(width: prominent ? 42 : 36, height: prominent ? 42 : 36)
                .background(
                    prominent ? AnyShapeStyle(.white.opacity(0.16)) : AnyShapeStyle(.clear),
                    in: Circle()
                )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(isFavorite ? "Remove \(entry.displayAnimal) from favorites" : "Add \(entry.displayAnimal) to favorites")
    }
}
