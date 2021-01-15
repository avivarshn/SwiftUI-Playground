import Foundation
import SwiftUI

struct CardViewModifier: ViewModifier {
    
    @State var eventType: EventType
    
    func body(content: Content) -> some View {
        return content
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(RoundedRectangle(cornerRadius: 15.0).gradientForeground(colors: [eventType.color()]).opacity(0.03))
    }
}
