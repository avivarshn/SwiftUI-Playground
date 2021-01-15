import Foundation
import SwiftUI

struct HexagonSnowflakeMacroOverview: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedHexagon()
                    .frame(width: geometry.size.width * 0.40, height: geometry.size.width * 0.40)
                
                RoundedHexagon()
                    .frame(width: geometry.size.width * 0.15, height: geometry.size.width * 0.15)
                    .padding(.trailing, geometry.size.width * 0.55)
                
                RoundedHexagon()
                    .frame(width: geometry.size.width * 0.15, height: geometry.size.width * 0.15)
                    .padding(.leading, geometry.size.width * 0.75)
            }
        }
    }
}

struct RoundedHexagon: View {
    
    var startColor: Color = UIColor.systemTeal.color
    var endColor: Color = .blue
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                var width: CGFloat = min(geometry.size.width, geometry.size.height)
                let height = width
                let xScale: CGFloat = 0.85
                let xOffset = (width * (1.0 - xScale)) / 2.0
                width *= xScale
                
                path.move(
                    to: CGPoint(
                        x: width * 0.95 + xOffset,
                        y: height * (0.20 + HexagonParameters.adjustment)
                    )
                )
                
                HexagonParameters.segments.forEach { segment in
                    path.addLine(
                        to: CGPoint(
                            x: width * segment.line.x + xOffset,
                            y: height * segment.line.y
                        )
                    )
                    
                    path.addQuadCurve(
                        to: CGPoint(
                            x: width * segment.curve.x + xOffset,
                            y: height * segment.curve.y
                        ),
                        control: CGPoint(
                            x: width * segment.control.x + xOffset,
                            y: height * segment.control.y
                        )
                    )
                }
            }
            .fill(LinearGradient(
                gradient: Gradient(colors: [startColor, endColor]),
                startPoint: UnitPoint(x: 0.5, y: 1.5),
                endPoint: UnitPoint(x: 0.5, y: 0)
            ))
        }
        .aspectRatio(1, contentMode: .fit)
    }
}
