import SwiftUI

struct BrowseView: View {
    let animals: [AnimalEntry]
    let favorites: FavoritesStore
    @State private var searchText = ""

    private var filteredAnimals: [AnimalEntry] {
        guard !searchText.isEmpty else { return animals }
        return animals.filter { entry in
            entry.animal.localizedCaseInsensitiveContains(searchText) ||
            entry.nouns.contains { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        List(filteredAnimals) { entry in
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
        .background(Color.appBackground)
        .listStyle(.plain)
        .listRowBackground(Color.appBackground)
        .navigationTitle("All animals")
        .toolbarBackground(Color.appBackground, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .searchable(text: $searchText, prompt: "Find an animal or collective noun")
    }
}

struct AnimalRow: View {
    let entry: AnimalEntry

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AnimalIconBadge(entry: entry, size: 54)

            VStack(alignment: .leading, spacing: 4) {
                Text(entry.displayAnimal)
                    .font(.headline)
                Text(entry.nouns.map { $0.replacingOccurrences(of: "\n", with: " ") }.joined(separator: " · "))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

struct AnimalDetailView: View {
    let entry: AnimalEntry
    let favorites: FavoritesStore

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HStack(alignment: .top, spacing: 16) {
                    AnimalIconBadge(entry: entry, size: 126)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("COLLECTIVE NOUNS FOR")
                            .font(.caption.weight(.bold))
                            .tracking(1.2)
                            .foregroundStyle(Color.appMuted)
                        Text(entry.displayAnimal)
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .minimumScaleFactor(0.7)
                            .lineLimit(3)
                        Text("\(entry.nouns.count) name\(entry.nouns.count == 1 ? "" : "s") in the source list")
                            .font(.subheadline.weight(.medium))
                            .foregroundStyle(.secondary)
                    }
                }

                VStack(alignment: .leading, spacing: 14) {
                    ForEach(entry.nouns, id: \.self) { noun in
                        HStack(spacing: 12) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(Color.teal)
                            Text(noun.replacingOccurrences(of: "\n", with: " "))
                                .font(.title3.weight(.semibold))
                            Spacer()
                        }
                        .padding(16)
                            .background(Color.appSurface, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                    }
                }

                Text("Try this one in a sentence: “\(entry.collectivePhrase).”")
                    .font(.body.weight(.medium))
                    .foregroundStyle(Color.appMuted)
                    .padding(.top, 4)
            }
            .padding(20)
        }
        .background(Color.appBackground.ignoresSafeArea())
        .navigationTitle(entry.displayAnimal)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.appBackground, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                FavoriteButton(entry: entry, favorites: favorites)
            }
        }
    }
}
