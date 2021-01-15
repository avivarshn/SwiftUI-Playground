import SwiftUI

struct MacroProgressChart: View {
    
    var order: [Int] = [0, 1, 2, 3, 4]
    var maxVals: [Double] = [96.0, 1200.0, 40.0, 166.0, 166.0]
    var progressVals: [Double] = [33.0, 850.0, 32.0, 120.0, 150.0]
    var sideLength: Double = 110.0
    var thickness: Double = 15.0
    var leadingColors: [Color] = [.purple, .blue, .green, .yellow, .orange]
    var trailingColors: [Color] = [.blue, .green, .yellow, .orange, .red]
    
    var body: some View {
        drawBody().padding()
    }
    
    func drawBody() -> some View {
        return ZStack(alignment: .center) {
            ForEach(0 ..< order.count) { i in
                let j = order[i]

                HexProgressBar(max: maxVals[j],progress: progressVals[j],
                               sideLength: sideLength - ((thickness + 5.0) * i.double),
                               thickness: thickness,
                               leadingColor: leadingColors[j], trailingColor: trailingColors[j])
                    .padding(.top, (thickness.cgFloat + 5.0) * i.cgFloat)
            }
        }
    }
}
