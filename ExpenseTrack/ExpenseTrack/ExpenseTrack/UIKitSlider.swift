import SwiftUI
import UIKit

/// A SwiftUI view that wraps a UIKit `UISlider`.
///
/// `UIKitSlider` allows you to use a `UISlider` in your SwiftUI views. It provides a binding to the slider's value.
///
/// - Tag: UIKitSlider
struct UIKitSlider: UIViewRepresentable {
    /// The current value of the slider.
    @Binding var value: Double

    /// Creates the `UISlider`.
    ///
    /// This method creates a new `UISlider` and sets up its target-action for the `.valueChanged` event.
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.addTarget(context.coordinator, action: #selector(Coordinator.valueChanged(_:)), for: .valueChanged)
        return slider
    }

    /// Updates the `UISlider` with the current value.
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(value)
    }

    /// Creates a `Coordinator` to handle the `UISlider`'s events.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    /// A class that handles the `UISlider`'s events.
    class Coordinator: NSObject {
        /// The `UIKitSlider` that owns this `Coordinator`.
        var parent: UIKitSlider

        /// Creates a new `Coordinator`.
        ///
        /// - Parameter parent: The `UIKitSlider` that owns this `Coordinator`.
        init(_ parent: UIKitSlider) {
            self.parent = parent
        }

        /// Handles the `UISlider`'s `.valueChanged` event.
        ///
        /// This method updates the `parent`'s `value` with the `UISlider`'s current value.
        ///
        /// - Parameter sender: The `UISlider` that triggered the event.
        @objc func valueChanged(_ sender: UISlider) {
            parent.value = Double(sender.value)
        }
    }
}
