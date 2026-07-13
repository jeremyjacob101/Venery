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
                        Text("The bundled list is adapted from cjwinchester’s public repository, which identifies Wikipedia’s “List of English terms of venery, by animal” as its source.")
                            .foregroundStyle(Color.appMuted)
                        Link("Open the GitHub dataset", destination: URL(string: "https://github.com/cjwinchester/collective-nouns-for-animals")!)
                        Link("Open the Wikipedia source", destination: URL(string: "https://en.wikipedia.org/wiki/List_of_English_terms_of_venery,_by_animal")!)
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text("License note")
                            .font(.headline)
                        Text("The GitHub repository does not include an explicit LICENSE file. Wikipedia text is generally available under CC BY-SA; confirm the current source terms and provide attribution/share-alike compliance before distributing this app commercially.")
                            .foregroundStyle(Color.appMuted)
                        Link("Read Wikipedia’s terms of use", destination: URL(string: "https://foundation.wikimedia.org/wiki/Policy:Terms_of_Use")!)
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
