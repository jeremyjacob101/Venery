import Foundation
import Observation

@Observable
final class FavoritesStore {
    private let storageKey = "favoriteAnimalIDs"
    private let defaults: UserDefaults

    private(set) var animalIDs: Set<String> {
        didSet {
            defaults.set(Array(animalIDs), forKey: storageKey)
        }
    }

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        self.animalIDs = Set(defaults.stringArray(forKey: storageKey) ?? [])
    }

    func contains(_ entry: AnimalEntry) -> Bool {
        animalIDs.contains(entry.id)
    }

    func toggle(_ entry: AnimalEntry) {
        if animalIDs.contains(entry.id) {
            animalIDs.remove(entry.id)
        } else {
            animalIDs.insert(entry.id)
        }
    }
}
