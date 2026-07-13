import SwiftUI

struct AboutView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    Image(systemName: "book.closed.fill")
                        .font(.system(size: 32))
                        .foregroundStyle(Color.teal)

                    Text("Venery is a tiny daily vocabulary lesson for the wonderfully specific names given to animal groups.")
                        .font(.title3.weight(.medium))

                    Divider()

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Data & attribution")
                            .font(.headline)
                        Text("The bundled list is adapted from Wikipedia’s “List of English terms of venery, by animal,” via cjwinchester’s public JSON dataset. The material is available under CC BY-SA 4.0 and has been modified for Venery.")
                            .foregroundStyle(Color.appMuted)
                        Link("Open the GitHub dataset", destination: URL(string: "https://github.com/cjwinchester/collective-nouns-for-animals")!)
                        Link("Open the Wikipedia source", destination: URL(string: "https://en.wikipedia.org/wiki/List_of_English_terms_of_venery,_by_animal")!)
                        Link("Read the CC BY-SA 4.0 license", destination: URL(string: "https://creativecommons.org/licenses/by-sa/4.0/")!)
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Modifications")
                            .font(.headline)
                        Text("Venery formats, selects, and presents this adapted material as a daily vocabulary experience. The bundled source and attribution notice are included with the app.")
                            .foregroundStyle(Color.appMuted)
                    }
                }
                .padding(24)
            }
            .background(Color.appBackground.ignoresSafeArea())
            .navigationTitle("About")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.appBackground, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    AboutView()
}
