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
    static let dataset: AnimalDataset = {
        guard let url = Bundle.main.url(forResource: "list-of-animal-venery", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let dataset = try? JSONDecoder().decode(AnimalDataset.self, from: data) else {
            return AnimalDataset(source: "", listOfAnimals: [])
        }

        return dataset
    }()

    static var animals: [AnimalEntry] {
        dataset.listOfAnimals
    }
}

enum DailyPicker {
    static func item(for date: Date, from animals: [AnimalEntry], calendar: Calendar = .current) -> AnimalEntry? {
        guard !animals.isEmpty else { return nil }

        let dayOfYear = calendar.ordinality(of: .day, in: .year, for: date) ?? 1
        let year = calendar.component(.year, from: date)
        let index = abs((year * 1_000) + dayOfYear) % animals.count
        return animals[index]
    }
}
