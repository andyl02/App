//  ComplexGestureView.swift

import SwiftUI

struct ComplexGestureView: View {
    @State private var offset = CGSize.zero
    @State private var rotation: Angle = .zero
    
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
