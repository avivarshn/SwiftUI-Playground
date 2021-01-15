import Foundation
import SwiftUI

struct WaterCardView : View {
    
    @ObservedObject var model = CardViewModel()
    @ObservedObject var event: WaterEvent
    @ObservedObject var macroData: MacroData
    @Binding var allEvents: [Event]
    
    var body: some View {
        ZStack(alignment: .trailing) {
            model.swipeToDelete { deleteThisEvent() }
            cardView()
        }
    }
    
    func cardView() -> some View {
        HStack(alignment: .center) {
            event.getCardViewHeader()
            Spacer()
            HStack(alignment: .bottom, spacing: 1) {
                Text(String(format: "%1.f", event.progress))
                    .font(.system(size: 22))
                    .bold()
                Text("/")
                    .font(.system(size: 22))
                Text(String(format: "%1.f oz", macroData.getMax()))
                    .font(.system(size: 14))
            }
            .foregroundColor(Color.gray)
        }
        .modifier(CardViewModifier(eventType: event.type))
        .offset(x: model.offset)
        .gesture(DragGesture().onChanged(model.onChanged(value:)).onEnded(model.onEnded(value:)))
    }
    
    func deleteThisEvent() {
        allEvents.removeAll { (event) -> Bool in
            return self.event.id == event.id
        }
    }
}
