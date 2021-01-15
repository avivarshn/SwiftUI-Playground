import Foundation
import SwiftUI

struct MeditationCardView : View {
    
    @ObservedObject var model = CardViewModel()
    @ObservedObject var event: MeditationEvent
    @Binding var allEvents: [Event]
    
    var body: some View {
        ZStack(alignment: .trailing) {
            model.swipeToDelete { deleteThisEvent() }
            cardView()
        }
    }
    
    func cardView() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            event.getCardViewHeader()
            Text("\(event.getShortSummary())").font(.system(size: 12))
                .padding(.leading, 5)
                .padding(.trailing, 5)
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
