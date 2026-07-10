import SwiftUI

struct ContentView: View {
    private let animals = AnimalStore.animals
    private let today = Date()

    @State private var showingBrowse = false
    @State private var showingAbout = false

    private var dailyAnimal: AnimalEntry? {
        DailyPicker.item(for: today, from: animals)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    if let dailyAnimal {
                        DailyCard(entry: dailyAnimal, date: today)
                    } else {
                        ContentUnavailableView("No animals yet", systemImage: "pawprint", description: Text("Add the bundled dataset to begin."))
                    }

                    HStack(spacing: 12) {
                        Label("One small word a day", systemImage: "sparkles")
                            .font(.subheadline.weight(.medium))
                            .foregroundStyle(.secondary)

                        Spacer()

                        Text("\(animals.count) animals")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.secondary)
                    }

                    Button {
                        showingBrowse = true
                    } label: {
                        HStack {
                            Label("See every animal and noun", systemImage: "square.grid.2x2")
                                .font(.headline)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.caption.weight(.bold))
                        }
                        .foregroundStyle(.primary)
                        .padding(18)
                        .background(.white.opacity(0.76), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                    }
                    .buttonStyle(.plain)
                    .accessibilityIdentifier("browse-all")
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 28)
            }
            .background(Color.appBackground.ignoresSafeArea())
            .navigationTitle("Venery")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showingBrowse = true
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }
                    .accessibilityLabel("Show all animals and collective nouns")
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAbout = true
                    } label: {
                        Image(systemName: "info.circle")
                    }
                    .accessibilityLabel("About Venery")
                }
            }
            .navigationDestination(isPresented: $showingBrowse) {
                BrowseView(animals: animals)
            }
            .sheet(isPresented: $showingAbout) {
                AboutView()
            }
        }
    }
}

private struct DailyCard: View {
    let entry: AnimalEntry
    let date: Date

    private var accent: Color {
        let value = entry.animal.utf8.reduce(0) { $0 + Int($1) }
        return [.coral, .teal, .gold, .plum][value % 4]
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(date.formatted(date: .long, time: .omitted).uppercased())
                    .font(.caption.weight(.bold))
                    .tracking(1.1)
                    .foregroundStyle(.white.opacity(0.78))

                Spacer()

                Label("1 MIN", systemImage: "clock")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.white.opacity(0.78))
            }

            Spacer(minLength: 42)

            HStack(alignment: .top, spacing: 14) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("A GROUP OF")
                        .font(.subheadline.weight(.bold))
                        .tracking(1.6)
                        .foregroundStyle(.white.opacity(0.82))

                    Text(entry.displayAnimal)
                        .font(.system(size: 42, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .minimumScaleFactor(0.72)
                        .lineLimit(2)
                }

                Spacer(minLength: 8)

                AnimalIconBadge(entry: entry, size: 86)
            }

            Text("Here are all the names in the list for this animal:")
                .font(.body.weight(.medium))
                .foregroundStyle(.white.opacity(0.9))
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, 16)

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 104), alignment: .leading)], alignment: .leading, spacing: 8) {
                ForEach(entry.nouns, id: \.self) { noun in
                    Text(noun.replacingOccurrences(of: "\n", with: " "))
                        .font(.caption.weight(.bold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .background(.white.opacity(0.16), in: Capsule())
                }
            }
            .padding(.top, 12)

            HStack(spacing: 8) {
                Image(systemName: "lightbulb.fill")
                Text("Say it once. Remember it all day.")
            }
            .font(.footnote.weight(.semibold))
            .foregroundStyle(.white.opacity(0.76))
            .padding(.top, 24)
        }
        .padding(24)
        .frame(maxWidth: .infinity, minHeight: 360, alignment: .leading)
        .background(
            LinearGradient(
                colors: [accent, accent.opacity(0.72)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ),
            in: RoundedRectangle(cornerRadius: 30, style: .continuous)
        )
        .shadow(color: accent.opacity(0.22), radius: 22, y: 12)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Today's animal: \(entry.animal). Collective nouns: \(entry.nouns.joined(separator: ", "))")
    }
}

extension Color {
    static let appBackground = Color(red: 0.95, green: 0.94, blue: 0.91)
    static let coral = Color(red: 0.78, green: 0.32, blue: 0.27)
    static let teal = Color(red: 0.10, green: 0.43, blue: 0.43)
    static let gold = Color(red: 0.72, green: 0.48, blue: 0.12)
    static let plum = Color(red: 0.39, green: 0.25, blue: 0.48)
}

#Preview {
    ContentView()
}
