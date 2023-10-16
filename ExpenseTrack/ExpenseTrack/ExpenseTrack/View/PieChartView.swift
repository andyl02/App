import SwiftUI

struct PieChartSegment: View {
    var startAngle: Angle
    var endAngle: Angle
    var color: Color
    var percentage: Double
    
    var body: some View {
        GeometryReader { geometry in
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            let radius = min(center.x, center.y)
            let labelPosition = CGPoint(
                x: center.x + radius * 0.7 * CGFloat(cos((startAngle + endAngle).radians / 2)),
                y: center.y + radius * 0.7 * CGFloat(sin((startAngle + endAngle).radians / 2))
            )
            
            ZStack {
                Path { path in
                    path.move(to: center)
                    path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                }
                .fill(color)
                
                Text("\(Int(percentage * 100))%")
                    .position(labelPosition)
                    .foregroundColor(.white)
            }
        }
    }
}

struct PieChartView: View {
    var data: [String: Double]
    private var total: Double {
        data.values.reduce(0, +)
    }
    
    private func endAngle(for value: Double) -> Angle {
        .degrees(360 * (value / total))
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                let sortedKeys = data.keys.sorted()
                ZStack {
                    ForEach(0..<sortedKeys.count, id: \.self) { index in
                        let key = sortedKeys[index]
                        let value = data[key] ?? 0
                        let startValue = sortedKeys.prefix(index).reduce(0) { $0 + (data[$1] ?? 0) }
                        let start = self.endAngle(for: startValue)
                        let end = self.endAngle(for: startValue + value)
                        PieChartSegment(
                            startAngle: start,
                            endAngle: end,
                            color: Color.random,
                            percentage: value / total
                        )
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                }
            }
            
            // Legend
            ForEach(data.keys.sorted(), id: \.self) { key in
                HStack {
                    Circle()
                        .fill(Color.random)
                        .frame(width: 20, height: 20)
                    Text(key)
                        .font(.headline)
                    Spacer()
                    Text("\(data[key] ?? 0, specifier: "%.2f")")
                        .font(.subheadline)
                }
                .padding(.horizontal)
            }
        }
    }
}

extension Color {
    static var random: Color {
        return Color(
            red: Double.random(in: 0..<1),
            green: Double.random(in: 0..<1),
            blue: Double.random(in: 0..<1)
        )
    }
}
