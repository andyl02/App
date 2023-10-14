// PieChartView.swift

// PieChartView.swift

import SwiftUI

struct PieChartView: View {
    var data: [Double]
    var title: String

    var body: some View {
        VStack {
            Text(title)
                .font(.title2)
            GeometryReader { geometry in
                PieChart(data: self.data)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

struct PieChart: Shape {
    var data: [Double]
    private var endAngles: [Angle]

    init(data: [Double]) {
        self.data = data
        endAngles = PieChart.calculateEndAngles(from: data)
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) * 0.5

        var startAngle = Angle(degrees: 0)
        for index in data.indices {
            path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngles[index], clockwise: false)
            startAngle = endAngles[index]
        }

        return path
    }

    private static func calculateEndAngles(from data: [Double]) -> [Angle] {
        let total = data.reduce(0, +)
        var endAngles: [Angle] = []
        var currentEndAngle = Angle(degrees: 0)

        for value in data {
            let segment = value / total
            currentEndAngle += Angle(degrees: 360 * segment)
            endAngles.append(currentEndAngle)
        }

        return endAngles
    }
}
