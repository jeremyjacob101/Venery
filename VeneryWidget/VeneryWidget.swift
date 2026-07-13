import SwiftUI
import WidgetKit

struct DailyAnimalEntry: TimelineEntry {
    let date: Date
    let animal: AnimalEntry?
}

struct DailyAnimalProvider: TimelineProvider {
    func placeholder(in context: Context) -> DailyAnimalEntry {
        DailyAnimalEntry(date: .now, animal: AnimalStore.animals.first)
    }

    func getSnapshot(in context: Context, completion: @escaping (DailyAnimalEntry) -> Void) {
        completion(entry(for: .now))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<DailyAnimalEntry>) -> Void) {
        let now = Date()
        let entry = entry(for: now)
        completion(Timeline(entries: [entry], policy: .after(DailyPicker.nextUpdate(after: now))))
    }

    private func entry(for date: Date) -> DailyAnimalEntry {
        DailyAnimalEntry(date: date, animal: DailyPicker.item(for: date, from: AnimalStore.animals))
    }
}

struct DailyAnimalWidgetView: View {
    @Environment(\.widgetFamily) private var family
    let entry: DailyAnimalEntry

    var body: some View {
        Group {
            if let animal = entry.animal {
                switch family {
                case .accessoryRectangular:
                    lockScreenView(animal)
                case .systemMedium:
                    mediumView(animal)
                default:
                    smallView(animal)
                }
            } else {
                ContentUnavailableView("No animals", systemImage: "pawprint")
            }
        }
        .containerBackground(for: .widget) {
            if family == .accessoryRectangular {
                Color.clear
            } else {
                LinearGradient(
                    colors: [Color(red: 0.13, green: 0.27, blue: 0.28), Color(red: 0.07, green: 0.16, blue: 0.18)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            }
        }
    }

    private func lockScreenView(_ animal: AnimalEntry) -> some View {
        HStack(spacing: 9) {
            ZStack {
                Circle()
                    .fill(.primary.opacity(0.14))
                Text(AnimalIconCatalog.glyph(for: animal.animal))
                    .font(.system(size: 24))
            }
            .frame(width: 38, height: 38)

            VStack(alignment: .leading, spacing: 1) {
                Text("A \(animal.primaryNoun.uppercased())")
                    .font(.caption.weight(.bold))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)

                Text("of \(animal.displayAnimal)")
                    .font(.caption.weight(.medium))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Today's venery: \(animal.collectivePhrase)")
    }

    private func smallView(_ animal: AnimalEntry) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("TODAY'S VENERY")
                .font(.caption2.weight(.bold))
                .tracking(1)
                .foregroundStyle(.white.opacity(0.7))

            Spacer(minLength: 8)

            Text(AnimalIconCatalog.glyph(for: animal.animal))
                .font(.system(size: 43))

            Text(animal.displayAnimal)
                .font(.title3.weight(.bold))
                .foregroundStyle(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.7)

            Text(animal.collectivePhrase)
                .font(.footnote.weight(.medium))
                .foregroundStyle(.white.opacity(0.84))
                .lineLimit(2)
                .minimumScaleFactor(0.75)
                .padding(.top, 4)
        }
        .padding(18)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Today's venery: \(animal.collectivePhrase)")
    }

    private func mediumView(_ animal: AnimalEntry) -> some View {
        HStack(alignment: .center, spacing: 18) {
            Text(AnimalIconCatalog.glyph(for: animal.animal))
                .font(.system(size: 62))
                .frame(width: 76)

            VStack(alignment: .leading, spacing: 5) {
                Text("TODAY'S VENERY")
                    .font(.caption2.weight(.bold))
                    .tracking(1.1)
                    .foregroundStyle(.white.opacity(0.7))

                Text(animal.displayAnimal)
                    .font(.title2.weight(.bold))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)

                Text(animal.collectivePhrase)
                    .font(.title3.weight(.medium))
                    .foregroundStyle(.white.opacity(0.88))
                    .lineLimit(2)
                    .minimumScaleFactor(0.7)
            }

            Spacer(minLength: 0)
        }
        .padding(20)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Today's venery: \(animal.collectivePhrase)")
    }
}

struct DailyAnimalWidget: Widget {
    let kind = "com.jeremyjacob.Venery.daily-animal"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: DailyAnimalProvider()) { entry in
            DailyAnimalWidgetView(entry: entry)
        }
        .configurationDisplayName("Today's Venery")
        .description("A daily animal collective noun for your Home and Lock Screens.")
        .supportedFamilies([.systemSmall, .systemMedium, .accessoryRectangular])
    }
}

@main
struct VeneryWidgetBundle: WidgetBundle {
    var body: some Widget {
        DailyAnimalWidget()
    }
}

#Preview(as: .systemSmall) {
    DailyAnimalWidget()
} timeline: {
    DailyAnimalEntry(date: .now, animal: AnimalStore.animals.first)
}

#Preview(as: .systemMedium) {
    DailyAnimalWidget()
} timeline: {
    DailyAnimalEntry(date: .now, animal: AnimalStore.animals.first)
}

#Preview(as: .accessoryRectangular) {
    DailyAnimalWidget()
} timeline: {
    DailyAnimalEntry(date: .now, animal: AnimalStore.animals.first)
}
