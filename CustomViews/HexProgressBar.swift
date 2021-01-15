import SwiftUI

struct HexProgressBar: View {
    
    var max: Double = 100.0
    @State var progress: Double = 100.0
    let sideLength: Double
    var thickness = 15.0
    var color = Color.blue
    var leadingColor = Color(UIColor.systemTeal)
    var trailingColor = Color(UIColor.blue)
    
    var body: some View {
        ZStack {
            _HexProgressBar(sideLength: sideLength, max: max, progress: max, thickness: thickness.cgFloat * 4.0)
                .stroke(style: StrokeStyle(lineWidth: thickness.cgFloat, lineCap: .round))
                .fill(color)
                .opacity(0.2)
            
            _HexProgressBar(sideLength: sideLength, max: max, progress: progress, thickness: thickness.cgFloat)
                .stroke(style: StrokeStyle(lineWidth: thickness.cgFloat, lineCap: .round))
                .fill(LinearGradient(gradient: Gradient(colors: [trailingColor, leadingColor]),
                                     startPoint: .top,
                                     endPoint: .bottom))
        }
    }
}

/**
 Hexagonal shaped progress bar. Draws background hexagon with a low opacity then actual progress on top.
 
 There are six sections, each section is (100 / 6 = 16.66) percentage of the overall progress.
 Hence sectionPercentage = (100.0 / 6.0)
 
 In order to determine how to calculate actual progress bar amount check to see how many full sections first.
 
 FullSectionCount = Int(Progress / sectionPercentage) // Only want whole number
 
 Draw FullSectionCount number of sections. For the next section determine how much remaining progress
 is left to show.
 
 RemainingProgress = Progress - (sectionPercentage * FullSectionCount)
 
 Say this value is "5", meaning five percent left to show. Calculate how much of a section "five" percent is,
 meaning how much of next section to show which represents "five" percent.
 
 remainingSectionPercentage = (RemainingProgress / sixth)
 
 Now we can simply calculate RemainingProgress amount of "xTravel" and "yTravel". Meaning how much
 of line to next point to draw.
 */

/**
 Progress Drawing Calculation
 
 This section goes over in detail two items:
 - Drawing hexagon shape
 - Drawing actual progress peice
 */
struct _HexProgressBar: Shape {
    
    let sideLength: Double
    var max: Double = 100.0
    @State var progress: Double = 100.0
    var thickness: CGFloat = 15.0
    
    func path(in rect: CGRect) -> Path {
        
        let halfThickness = thickness / 2.0
        
        let SIXTH: Double = (max / 6.0)
        let numSections: Int = Int((progress / SIXTH));
        let xTravel = CGFloat(sideLength * cos(30.0.asRadians));
        let yTravel = CGFloat(sideLength * sin(30.0.asRadians));
        
        return Path { path in
            let w = rect.width
            
            let p0 = CGPoint(x: w / 2, y: 0)
            let p1 = CGPoint(x: p0.x + xTravel, y: p0.y + yTravel)
            let p2 = CGPoint(x: p1.x, y: p1.y + sideLength.cgFloat)
            let p3 = CGPoint(x: p2.x - xTravel, y: p2.y + yTravel)
            let p4 = CGPoint(x: p3.x - xTravel, y: p3.y - yTravel)
            let p5 = CGPoint(x: p4.x, y: p4.y - sideLength.cgFloat)
            let points:[CGPoint] = [p1, p2, p3, p4, p5, p0]
            
            // Start at p0.
            path.move(to: p0)
            
//            for i in 0 ..< points.count {
//                var p = points[i]
//
//               // path.move(to: p)
//                path.addEllipse(in: CGRect(x: p.x - halfThickness, y: p.y - halfThickness, width: thickness, height: thickness))
//            }
            
            // Draws in FULL sections, index i will be remaining sections after loop.
            var lastIndex = 0
            for i in 0 ..< points.count {
                if i < numSections {
                    path.addLine(to: points[i])//CGPoint(x: points[i] - halfThickness, y: points[i].y - halfThickness))
                } else {
                    lastIndex = i
                    break
                }
            }

            let remainingProgress: Double = progress - (Double(lastIndex) * SIXTH)
            let sectionPercentage: Double = (remainingProgress / SIXTH)

            if numSections == 0 {
                let newX: CGFloat = p0.x + (xTravel * sectionPercentage.cgFloat)
                let newY: CGFloat = p0.y + (yTravel * sectionPercentage.cgFloat)
                path.addLine(to: CGPoint(x: newX, y: newY))

            } else if numSections == 1 {
                let newX: CGFloat = p1.x
                let newY: CGFloat = p1.y + (sideLength.cgFloat * sectionPercentage.cgFloat)
                path.addLine(to: CGPoint(x: newX, y: newY))

            } else if numSections == 2 {
                let newX: CGFloat = p2.x - (xTravel * sectionPercentage.cgFloat)
                let newY: CGFloat = p2.y + (yTravel * sectionPercentage.cgFloat)
                path.addLine(to: CGPoint(x: newX, y: newY))

            } else if numSections == 3 {
                let newX: CGFloat = p3.x - (xTravel * sectionPercentage.cgFloat)
                let newY: CGFloat = p3.y - (yTravel * sectionPercentage.cgFloat)
                path.addLine(to: CGPoint(x: newX, y: newY))

            } else if numSections == 4 {
                let newX: CGFloat = p4.x
                let newY: CGFloat = p4.y - (sideLength.cgFloat * sectionPercentage.cgFloat)
                path.addLine(to: CGPoint(x: newX, y: newY))

            } else if numSections == 5 {
                let newX: CGFloat = p5.x + (xTravel * sectionPercentage.cgFloat)
                let newY: CGFloat = p5.y - (yTravel * sectionPercentage.cgFloat)
                path.addLine(to: CGPoint(x: newX, y: newY))

            }
        }
    }
}

#if DEBUG
struct HexProgressBar_Previews: PreviewProvider {
    static var previews: some View{
        HexProgressBar(max: 96, progress: (96/3.0), sideLength: 110.0, leadingColor: Color.purple, trailingColor: Color.blue)
    }
}
#endif
