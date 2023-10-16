//  UIKitSliderInSwiftUI.swift

import SwiftUI
import UIKit

struct UIKitSliderInSwiftUI: View {
    @State private var value: Double = 0
    
    var body: some View {
        UIKitSlider(value: $value)
            .frame(height: 40)
    }
}

struct UIKitSliderInSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        UIKitSliderInSwiftUI()
    }
}
