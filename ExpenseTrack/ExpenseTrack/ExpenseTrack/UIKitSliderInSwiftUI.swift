import SwiftUI
import UIKit

/// A SwiftUI view that uses a `UIKitSlider`.
///
/// `UIKitSliderInSwiftUI` demonstrates how to use a `UIKitSlider` in a SwiftUI view.
///
/// - Tag: UIKitSliderInSwiftUI
struct UIKitSliderInSwiftUI: View {
    /// The current value of the slider.
    @State private var value: Double = 0
    
    /// The body of the `UIKitSliderInSwiftUI`.
    var body: some View {
        UIKitSlider(value: $value)
            .frame(height: 40)
    }
}

/// A SwiftUI preview provider for the `UIKitSliderInSwiftUI`.
///
/// `UIKitSliderInSwiftUI_Previews` generates a preview of the `UIKitSliderInSwiftUI`.
struct UIKitSliderInSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        UIKitSliderInSwiftUI()
    }
}
