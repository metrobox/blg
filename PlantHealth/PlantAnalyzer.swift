import Foundation
import Vision
import CoreML
import UIKit

enum PlantAnalyzerError: Error {
    case failed
}

class PlantAnalyzer {
    static let shared = PlantAnalyzer()
    private let model: VNCoreMLModel?

    private init() {
        if let url = Bundle.main.url(forResource: "PlantConditionClassifier", withExtension: "mlmodelc"),
           let coreMLModel = try? MLModel(contentsOf: url) {
            model = try? VNCoreMLModel(for: coreMLModel)
        } else {
            model = nil
        }
    }

    func analyze(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let model = model,
              let ciImage = CIImage(image: image) else {
            completion(.failure(PlantAnalyzerError.failed))
            return
        }

        let request = VNCoreMLRequest(model: model) { request, error in
            if let result = request.results?.first as? VNClassificationObservation {
                completion(.success("Condition: \(result.identifier) (confidence: \(Int(result.confidence * 100))%)"))
            } else if let error = error {
                completion(.failure(error))
            } else {
                completion(.failure(PlantAnalyzerError.failed))
            }
        }

        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([request])
            } catch {
                completion(.failure(error))
            }
        }
    }
}
