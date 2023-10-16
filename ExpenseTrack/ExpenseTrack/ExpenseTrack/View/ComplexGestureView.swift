import SwiftUI

/// `ComplexGestureView` is a SwiftUI view that responds to complex gestures.
///
/// This view displays a rectangle that can be dragged and rotated using simultaneous gestures.
struct ComplexGestureView: View {
    /// The current offset of the rectangle from its original position.
    @State private var offset = CGSize.zero
    
    /// The current rotation of the rectangle.
    @State private var rotation: Angle = .zero
    
    /// The body of the `ComplexGestureView`.
    var body: some View {
        Rectangle()
            .fill(Color.blue)
            .frame(width: 100, height: 100)
            .offset(offset)
            .rotationEffect(rotation)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        self.offset = gesture.translation
                    }
                    .simultaneously(
                        with: RotationGesture()
                            .onChanged { angle in
                                self.rotation = angle
                            }
                    )
            )
    }
}

