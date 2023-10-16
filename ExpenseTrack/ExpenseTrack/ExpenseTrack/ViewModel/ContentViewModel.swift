import SwiftUI

/// `ContentViewModel` is a SwiftUI view model for the content view.
///
/// This class provides a published property for the value of a slider in the content view.
class ContentViewModel: ObservableObject {
    /// The current value of the slider.
    @Published var sliderValue: Double = 0.5
}
