import SwiftUI

extension View {
    @ViewBuilder func visibility(_ hide: Bool) -> some View {
        switch hide {
        case false: self.hidden()
        case true: self
        }
    }
    
    public func gradientForeground(colors: [Color], opacity: Double = 1.0) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing))
            .mask(self)
            .opacity(opacity)
    }
    
    
    public func gradientBackground(colors: [Color], opacity: Double = 1.0) -> some View {
        
        self.background(LinearGradient(gradient: .init(colors: colors),
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing))
            .opacity(opacity)
    }
    
    public func animationHeartBeat(active: Bool) -> some View {
        
		return self.scaleEffect(active ? AppData.ANIMATION_HEARTBEAT_SCALE : 1.0)
            .animation(active ?
						Animation.interpolatingSpring(stiffness: AppData.ANIMATION_HEARTBEAT_STIFFNESS,
													  damping: AppData.ANIMATION_HEARTBEAT_DAMPENING)
						.speed(AppData.ANIMATION_HEARTBEAT_SPEED)
                        .repeatForever(autoreverses: true)
                        : Animation.default)
    }
}
