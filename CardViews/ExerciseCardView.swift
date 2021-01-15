import Foundation
import SwiftUI

struct ExerciseCardView : View {
    
    @ObservedObject var model = CardViewModel()
    @ObservedObject var event: ExerciseEvent
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
            ExerciseList(event: event)
                .padding(.leading, 10)
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

struct ExerciseList: View {
    
    @ObservedObject var event: ExerciseEvent
    
    var body: some View {
        var list: [Exercise] = event.getExercises()
        
        VStack(alignment: .leading, spacing: 5) {
            ForEach (0 ..< list.count) { i in
                HStack() {
                    Image(systemName: "dot.square").frame(width: 8, height: 8)
                    Text("\(list[i].name) \(String(format: "%.2f", list[i].duration)) hr").font(.system(size: 12))
                }
            }
        }
    }
}
