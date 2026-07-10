import SwiftUI

struct AnimalIcon: View {
    let animal: String
    let size: CGFloat

    init(entry: AnimalEntry, size: CGFloat) {
        self.animal = entry.animal
        self.size = size
    }

    var body: some View {
        Text(AnimalIconCatalog.glyph(for: animal))
            .font(.system(size: size * 0.58))
            .minimumScaleFactor(0.45)
            .frame(width: size, height: size)
            .accessibilityHidden(true)
    }
}

struct AnimalIconBadge: View {
    let entry: AnimalEntry
    let size: CGFloat

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.24, style: .continuous)
                .fill(.white.opacity(0.88))
            AnimalIcon(entry: entry, size: size * 0.82)
        }
        .frame(width: size, height: size)
    }
}

enum AnimalIconCatalog {
    private static let glyphs: [String: String] = [
        "antelopes": "🦌",
        "ants": "🐜",
        "apes": "🦍",
        "asses": "🫏",
        "baboons": "🐒",
        "badgers": "🦡",
        "bats": "🦇",
        "bears": "🐻",
        "beavers": "🦫",
        "bees": "🐝",
        "birds": "🐦",
        "bitterns": "🐦",
        "boars (wild boars)": "🐗",
        "buffalo": "🦬",
        "bullfinches": "🐦",
        "bullocks": "🐂",
        "butterflies": "🦋",
        "capercaillie": "🐦",
        "capons": "🐔",
        "caribou": "🦌",
        "cats": "🐈",
        "wild cats (feral cats)": "🐈‍⬛",
        "cattle": "🐄",
        "chickens": "🐔",
        "choughs": "🐦",
        "colts": "🐎",
        "cormorants": "🐦",
        "coots": "🐦",
        "coyotes": "🐺",
        "cranes": "🐦",
        "crocodiles": "🐊",
        "crows": "🐦‍⬛",
        "curlews": "🐦",
        "deer": "🦌",
        "dogs": "🐕",
        "dolphins": "🐬",
        "dotterel": "🐦",
        "doves": "🕊️",
        "ducks": "🦆",
        "dunlins": "🐦",
        "eagles": "🦅",
        "eels": "🐟",
        "elephants": "🐘",
        "elk": "🦌",
        "falcons": "🦅",
        "ferrets": "🦦",
        "finches": "🐦",
        "fish": "🐟",
        "flamingoes": "🦩",
        "flies": "🪰",
        "foxes": "🦊",
        "frogs": "🐸",
        "geese": "🪿",
        "giraffes": "🦒",
        "gnats": "🦗",
        "goats": "🐐",
        "goldfinches": "🐦",
        "goosanders": "🦆",
        "gorillas": "🦍",
        "goshawks": "🐦",
        "grasshoppers": "🦗",
        "grouse": "🐦",
        "guineafowl": "🐦",
        "hares": "🐇",
        "harts": "🦌",
        "hawks": "🦅",
        "hedgehogs": "🦔",
        "hens": "🐔",
        "herons": "🐦",
        "hippopotamuses": "🦛",
        "hogs": "🐖",
        "hornets": "🐝",
        "horses": "🐎",
        "hounds": "🐕",
        "hyenas": "🦊",
        "ibex": "🐐",
        "ibises": "🐦",
        "iguanas": "🦎",
        "insects": "🐞",
        "jackdaws": "🐦",
        "jays": "🐦",
        "jellyfish": "🪼",
        "kangaroos": "🦘",
        "kittens": "🐈",
        "lapwings": "🐦",
        "larks": "🐦",
        "leopards": "🐆",
        "lions": "🦁",
        "locusts": "🦗",
        "mackerel": "🐟",
        "magpies": "🐦",
        "mallards": "🦆",
        "mares": "🐎",
        "martens": "🦦",
        "mice": "🐁",
        "minnows": "🐟",
        "moles": "🦔",
        "monkeys": "🐒",
        "moorhens": "🐦",
        "moose": "🫎",
        "mosquitoes": "🦟",
        "mudhens": "🐔",
        "mules": "🫏",
        "nightingales": "🐦",
        "owls": "🦉",
        "oxen": "🐂",
        "oysters": "🦪",
        "parrots": "🦜",
        "partridges": "🐦",
        "peacocks": "🦚",
        "pelicans": "🐦",
        "penguins": "🐧",
        "pheasants": "🐦",
        "pigs": "🐖",
        "pigeons": "🕊️",
        "plovers": "🐦",
        "quail": "🐦",
        "rabbits": "🐇",
        "raccoons": "🦝",
        "ravens": "🐦‍⬛",
        "rhinoceroses": "🦏",
        "rooks": "🐦‍⬛",
        "salmon": "🐟",
        "sandpipers": "🐦",
        "seals": "🦭",
        "sea urchins": "🪸",
        "sheep": "🐑",
        "sheldrake": "🦆",
        "snails": "🐌",
        "snakes": "🐍",
        "snipes": "🐦",
        "sparrows": "🐦",
        "spiders": "🕷️",
        "squirrels": "🐿️",
        "starlings": "🐦",
        "stoats": "🦦",
        "storks": "🐦",
        "swallows": "🐦",
        "swans": "🦢",
        "swifts": "🐦",
        "swine": "🐖",
        "teal": "🦆",
        "tigers": "🐅",
        "toads": "🐸",
        "trout": "🐟",
        "turkeys": "🦃",
        "turtles": "🐢",
        "turtle doves": "🕊️",
        "vipers": "🐍",
        "walruses": "🦭",
        "waterfowl": "🐦",
        "weasels": "🦦",
        "whales": "🐋",
        "wigeons": "🦆",
        "wildfowl": "🐦",
        "wolves": "🐺",
        "wombats": "🐻",
        "woodcocks": "🐦",
        "woodpeckers": "🐦",
        "wrens": "🐦",
        "zebras": "🦓"
    ]

    static func glyph(for animal: String) -> String {
        glyphs[animal] ?? "🐾"
    }
}
