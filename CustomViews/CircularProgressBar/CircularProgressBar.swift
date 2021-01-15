import SwiftUI

struct CircularProgressBar {
    
    let title: String
    @Binding var max: Float
    @Binding var progress: Float
    var backgroundColor: Color = Color.blue
    var startColor: Color = Color.blue
    var endColor: Color = Color.purple
    var thickness: CGFloat = 30.0
    var showTitle: Bool = false
    var showPercentage: Bool = false
}

struct CircularProgressBarView: View {
    
    var config: CircularProgressBar
    
    var animation: Animation {
        Animation.easeInOut(duration: 1)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text(config.title)
                .bold()
                .visibility(config.showTitle)
            ZStack {
                Circle()
                    .stroke(lineWidth: config.thickness)
                    .opacity(0.1)
                    .foregroundColor(config.backgroundColor)
                Circle()
                    .trim(from: 0, to: CGFloat(config.progress / config.max))
                    .stroke(LinearGradient(
                                gradient: Gradient(colors: [config.startColor, config.endColor]),
                                startPoint: .trailing,
                                endPoint: .leading),
                            style: StrokeStyle(lineWidth: config.thickness, lineCap: .round, lineJoin: .round))
                    .foregroundColor(config.backgroundColor)
                    .rotationEffect(Angle(degrees: -90))
                    .animation(.linear)
                Text("\(Int(100.0 * self.config.progress / self.config.max)) %")
                    .bold()
                    .foregroundColor((self.config.progress / self.config.max) > 1 ? Color.red : Color.black)
                    .visibility(self.config.showPercentage)
            }
            .animation (
                .easeInOut(duration: 2)
            )
        }
    }
}

#if DEBUG
struct CircularProgressBar_Previews: PreviewProvider {
    
    static var previews: some View {
        CircularProgressBarView(config: CircularProgressBar(title: "Water",
                                                            max: .constant(96), progress: .constant(12),
                                                            backgroundColor: .macroBarWaterBackgroundColor, startColor: .macroBarWaterStartColor, endColor: .macroBarWaterEndColor))
    }
}
#endif
