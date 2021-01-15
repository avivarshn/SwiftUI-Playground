import SwiftUI

/**
 A hexagon with alignment on top of the frame of the view containing it.
 */
struct Hexagon: Shape {
    
    let sideLength: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let xTravel:CGFloat = sideLength * CGFloat(cos(30.0.asRadians));
        let yTravel:CGFloat = sideLength * CGFloat(sin(30.0.asRadians));
        
        return Path { path in
            let w = rect.width
            
            // Calculate all six points of hexagon, with P0 being top most point.
            let p0 = CGPoint(x: w / 2, y: 0)
            let p1 = CGPoint(x: p0.x + xTravel, y: p0.y + yTravel)
            let p2 = CGPoint(x: p1.x, y: p1.y + sideLength)
            let p3 = CGPoint(x: p2.x - xTravel, y: p2.y + yTravel)
            let p4 = CGPoint(x: p3.x - xTravel, y: p3.y - yTravel)
            let p5 = CGPoint(x: p4.x, y: p4.y - sideLength)
            let points:[CGPoint] = [p1, p2, p3, p4, p5, p0]

            path.move(to: p0)
            for i in 0 ..< points.count {
                path.addLine(to: points[i])
            }
        }
    }
}

#if DEBUG
struct Hexagon_Previews: PreviewProvider {
    static var previews: some View{
        Hexagon(sideLength: 50.0).border(Color.red).frame(width: 100, height: 100)
    }
}
#endif
