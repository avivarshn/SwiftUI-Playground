import Foundation
import SwiftUI

class CardViewModel: ObservableObject {
    
    private let OFFSET_ZERO: CGFloat = 0
    private let OFFSET_DELETE_IS_SWIPED: CGFloat = -75
    private let OFFSET_DETECT_SWIPE: CGFloat = 50

    @Published var offset: CGFloat = 0
    
    func isSwiped() -> Bool { return offset == OFFSET_DELETE_IS_SWIPED }
    
    func onChanged(value: DragGesture.Value) {
        if value.translation.width < OFFSET_ZERO {
            if offset == -OFFSET_DETECT_SWIPE { offset = value.translation.width - -OFFSET_DELETE_IS_SWIPED }
            else { offset = value.translation.width }
        }
    }
    
    func onEnded(value: DragGesture.Value) {
        withAnimation(.easeOut) {
            if value.translation.width  < OFFSET_ZERO {
                 if -offset > OFFSET_DETECT_SWIPE {
                    offset = OFFSET_DELETE_IS_SWIPED}
                 else { offset = OFFSET_ZERO }
            } else { offset = OFFSET_ZERO }
        }
    }
    
    func swipeToDelete(onDeletePressed: @escaping () -> Void) -> some View {
        ZStack(alignment: .trailing) {
            RoundedRectangle(cornerRadius: 15.0).fill(Color.red)
                .frame(width: 50)
                .padding(.trailing, 10)
            
            HStack {
                Spacer()
                Button(action: {
                    onDeletePressed()
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                }
            }
            .padding(.trailing, 10)
        }
        .visibility(isSwiped())
    }
}
