import SwiftUI

/// `ContentView` is the main SwiftUI view of the application.
///
/// This view displays a text view that shows the current value of a slider, a UIKit-based slider, and the home view of the application.
struct ContentView: View {
    
    /// The view model for the content view.
    @ObservedObject var viewModel = ContentViewModel()

    /// The body of the `ContentView`.
    var body: some View {
        NavigationView {
            VStack {
                Text("Slider Value: \(viewModel.sliderValue)")
                
                /// UIKit-based slider.
                UIKitSlider(value: $viewModel.sliderValue)
                
                /// Home view displaying the list of expenses.
                HomeView()
                    .environmentObject(ExpenseManager())
            }
        }
    }
}

/// `ContentView_Previews` is a SwiftUI preview provider for the `ContentView`.
///
/// This struct generates a preview of the `ContentView`.
struct ContentView_Previews: PreviewProvider {
    
    /// Generates a preview of the `ContentView`.
    static var previews: some View {
        ContentView()
    }
}
