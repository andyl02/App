import CoreML

/// A class that uses a Core ML model to classify text.
///
/// `TextClassifier` uses the `ExpenseCategoryPredictor` Core ML model to predict the category of an expense based on its description.
///
/// - Tag: TextClassifier
class TextClassifier {

    /// The Core ML model used for text classification.
    private let model: ExpenseCategoryPredictor

    /// Initializes a new `TextClassifier`.
    ///
    /// This initializer loads the `ExpenseCategoryPredictor` Core ML model. If the model cannot be loaded, it causes a runtime error.
    init() {
        // Initialize the Core ML model
        guard let loadedModel = try? ExpenseCategoryPredictor (configuration: MLModelConfiguration()) else {
            fatalError("Could not load the Core ML model.")
        }
        self.model = loadedModel
    }

    /// Classifies a given text.
    ///
    /// This method uses the Core ML model to predict the category of an expense based on its description.
    ///
    /// - Parameter text: The text to classify.
    /// - Returns: The predicted category, or `nil` if the prediction fails.
    func classifyText(_ text: String) -> String? {
        // Use the Core ML model to make predictions
        if let prediction = try? model.prediction(text: text) {
            return prediction.label
        } else {
            return nil
        }
    }
}
