import Foundation

struct AnimalEntry: Codable, Hashable, Identifiable {
    let animal: String
    let nouns: [String]

    var id: String { animal }

    var displayAnimal: String {
        animal.capitalized
    }

    var primaryNoun: String {
        nouns.first ?? "group"
    }

    var collectivePhrase: String {
        "a \(primaryNoun.replacingOccurrences(of: "\\n", with: " ")) of \(animal)"
    }

    var displayCollectivePhrase: String {
        guard let firstCharacter = collectivePhrase.first else { return collectivePhrase }
        return firstCharacter.uppercased() + collectivePhrase.dropFirst()
    }
}

struct AnimalDataset: Codable {
    let source: String
    let listOfAnimals: [AnimalEntry]

    enum CodingKeys: String, CodingKey {
        case source
        case listOfAnimals = "list_of_animals"
    }
}

enum AnimalStore {
    static let dataset = load()

    static func load(bundle: Bundle = .main) -> AnimalDataset {
        guard let url = bundle.url(forResource: "list-of-animal-venery", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let dataset = try? JSONDecoder().decode(AnimalDataset.self, from: data) else {
            return AnimalDataset(source: "", listOfAnimals: [])
        }

        return dataset
    }

    static var animals: [AnimalEntry] {
        dataset.listOfAnimals
    }
}

enum DailyPicker {
    static let utcCalendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? .gmt
        return calendar
    }()

    static func item(for date: Date, from animals: [AnimalEntry], calendar: Calendar = utcCalendar) -> AnimalEntry? {
        guard !animals.isEmpty else { return nil }

        let dayOfYear = calendar.ordinality(of: .day, in: .year, for: date) ?? 1
        let year = calendar.component(.year, from: date)
        let shuffledIndices = shuffledIndices(for: year, count: animals.count)
        return animals[shuffledIndices[(dayOfYear - 1) % animals.count]]
    }

    static func nextUpdate(after date: Date, calendar: Calendar = utcCalendar) -> Date {
        let startOfToday = calendar.startOfDay(for: date)
        return calendar.date(byAdding: .day, value: 1, to: startOfToday) ?? date.addingTimeInterval(86_400)
    }

    private static func shuffledIndices(for year: Int, count: Int) -> [Int] {
        var indices = Array(0 ..< count)
        var state = stableSeed(for: "venery-daily-\(year)-v1")

        guard count > 1 else { return indices }

        for index in 0 ..< (count - 1) {
            let offset = Int(nextRandom(&state) % UInt64(count - index))
            indices.swapAt(index, index + offset)
        }

        return indices
    }

    private static func stableSeed(for string: String) -> UInt64 {
        string.utf8.reduce(14_695_981_039_346_656_037) { hash, byte in
            (hash ^ UInt64(byte)) &* 1_099_511_628_211
        }
    }

    private static func nextRandom(_ state: inout UInt64) -> UInt64 {
        state &+= 0x9E3779B97F4A7C15
        var value = state
        value = (value ^ (value >> 30)) &* 0xBF58476D1CE4E5B9
        value = (value ^ (value >> 27)) &* 0x94D049BB133111EB
        return value ^ (value >> 31)
    }
}
