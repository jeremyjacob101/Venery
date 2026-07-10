import SwiftUI

struct BrowseView: View {
    let animals: [AnimalEntry]
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
            NavigationLink(value: entry) {
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
                .padding(.vertical, 5)
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.appBackground)
        .navigationTitle("All animals")
        .searchable(text: $searchText, prompt: "Find an animal")
        .navigationDestination(for: AnimalEntry.self) { entry in
            AnimalDetailView(entry: entry)
        }
    }
}

private struct AnimalDetailView: View {
    let entry: AnimalEntry

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HStack(alignment: .top, spacing: 16) {
                    AnimalIconBadge(entry: entry, size: 126)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("COLLECTIVE NOUNS FOR")
                            .font(.caption.weight(.bold))
                            .tracking(1.2)
                            .foregroundStyle(.secondary)
                        Text(entry.displayAnimal)
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .minimumScaleFactor(0.7)
                            .lineLimit(3)
                        Text("\(entry.nouns.count) names in the source list")
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
                        .background(.white.opacity(0.72), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                    }
                }

                Text("Try this one in a sentence: “a \(entry.primaryNoun) of \(entry.animal).”")
                    .font(.body.weight(.medium))
                    .foregroundStyle(.secondary)
                    .padding(.top, 4)
            }
            .padding(20)
        }
        .background(Color.appBackground.ignoresSafeArea())
        .navigationTitle(entry.displayAnimal)
        .navigationBarTitleDisplayMode(.inline)
    }
}
