import SwiftUI

struct ContentView: View {
    @State private var jokeText: String = "Tap to load a joke"

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(jokeText)
                .padding()
            Button("Load Joke") {
                loadJoke()
            }
        }
        .padding()
    }

    func loadJoke() {
        guard let url = URL(string: "https://api.chucknorris.io/jokes/random") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Joke.self, from: data) {
                    DispatchQueue.main.async {
                        self.jokeText = decodedResponse.value
                    }
                }
            } else if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Joke: Codable {
    var value: String
}

