import SwiftUI

struct CircularProgressBarItem: Identifiable {
    let id: Int
    let title: String
    @State var max: Float
    @State var progress: Float
    var backgroundColor: Color = Color.blue
    var startColor: Color = Color.blue
    var endColor: Color = Color.purple
    var thickness: CGFloat = 30.0
    var showTitle: Bool = false
    var showPercentage: Bool = false
}
