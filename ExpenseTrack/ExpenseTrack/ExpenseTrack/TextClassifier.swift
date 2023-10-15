//  TextClassifier.swift

import CoreML

class TextClassifier {

    // Declare a property to hold the Core ML model
    private let model: ExpenseCategoryPredictor

    init() {
        // Initialize the Core ML model
        guard let loadedModel = try? ExpenseCategoryPredictor (configuration: MLModelConfiguration()) else {
            fatalError("Could not load the Core ML model.")
        }
        self.model = loadedModel
    }

    // Define a function to make predictions
    func classifyText(_ text: String) -> String? {
        // Use the Core ML model to make predictions
        if let prediction = try? model.prediction(text: text) {
            return prediction.label
        } else {
            return nil
        }
    }
}
