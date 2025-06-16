import SwiftUI

struct ContentView: View {
    @State private var showCamera = false
    @State private var image: UIImage?
    @State private var resultText: String = ""

    var body: some View {
        VStack(spacing: 20) {
            if let uiImage = image {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            } else {
                Rectangle()
                    .foregroundColor(.secondary)
                    .frame(height: 300)
                    .overlay(Text("No Image"))
            }

            Text(resultText)
                .font(.headline)
                .padding()

            Button(action: { showCamera = true }) {
                Text("Take Photo")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .sheet(isPresented: $showCamera) {
            ImagePicker(image: $image, onImagePicked: analyze)
        }
    }

    private func analyze() {
        guard let image = image else { return }
        resultText = "Analyzing..."
        PlantAnalyzer.shared.analyze(image: image) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let text):
                    resultText = text
                case .failure(let error):
                    resultText = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
