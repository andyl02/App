import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Text("Slider Value: \(viewModel.sliderValue)")
                UIKitSlider(value: $viewModel.sliderValue)
                HomeView()
                    .environmentObject(ExpenseManager())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
