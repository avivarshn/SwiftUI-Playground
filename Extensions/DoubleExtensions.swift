import SwiftUI

extension Double {
    var asDegrees: Double { return self * 180 / .pi }
    var asRadians: Double { return self * .pi / 180 }
    var cgFloat: CGFloat { return CGFloat(self) }
    var float: Float { return Float(self) }
}
