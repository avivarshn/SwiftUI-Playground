import Foundation
import SwiftUI

struct FoodCardView: View {
    
    @ObservedObject var model = CardViewModel()
    @ObservedObject var event: FoodEvent
    @State var macros: [MacroData]
    @Binding var allEvents: [Event]
    
    var body: some View {
        ZStack(alignment: .trailing) {
            model.swipeToDelete { deleteThisEvent() }
            cardView()
        }
    }
    
    func cardView() -> some View {
        VStack(alignment: .leading) {
            event.getCardViewHeader()
            
            HStack(alignment: .bottom) {
                HStack(alignment: .bottom, spacing: 1) {
                    Text(String(format: "%1.f", event.totalMacroCount(macroType: MacroType.CAL)))
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(event.totalMacroCount(macroType: MacroType.CAL) > macros[MacroType.CAL.rawValue].getMax() ? Color.red : Color.gray)
                    Text("/")
                        .font(.system(size: 20))
                    Text(String(format: "%1.fg Cal", macros[MacroType.CAL.rawValue].getMax()))
                        .font(.system(size: 12))
                }
                .foregroundColor(Color.gray)
                
                Spacer()
                
                HStack(alignment: .bottom, spacing: 1) {
                    Text(String(format: "%1.f", event.totalMacroCount(macroType: MacroType.FAT)))
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(event.totalMacroCount(macroType: MacroType.FAT) > macros[MacroType.FAT.rawValue].getMax() ? Color.red : Color.gray)
                    Text("/")
                        .font(.system(size: 20))
                    Text(String(format: "%1.fg Fat", macros[MacroType.FAT.rawValue].getMax()))
                        .font(.system(size: 12))
                }
                .foregroundColor(Color.gray)
                
                Spacer()
                
                HStack(alignment: .bottom, spacing: 1) {
                    Text(String(format: "%1.f", event.totalMacroCount(macroType: MacroType.CARB)))
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(event.totalMacroCount(macroType: MacroType.CARB) > macros[MacroType.CARB.rawValue].getMax() ? Color.red : Color.gray)
                    Text("/")
                        .font(.system(size: 20))
                    Text(String(format: "%1.fg Carb", macros[MacroType.CARB.rawValue].getMax()))
                        .font(.system(size: 12))
                }
                .foregroundColor(Color.gray)
                
                Spacer()
                
                HStack(alignment: .bottom, spacing: 1) {
                    Text(String(format: "%1.f", event.totalMacroCount(macroType: MacroType.PROTEIN)))
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(event.totalMacroCount(macroType: MacroType.PROTEIN) > macros[MacroType.PROTEIN.rawValue].getMax() ? Color.red : Color.gray)
                    Text("/")
                        .font(.system(size: 20))
                    Text(String(format: "%1.fg Pro", macros[MacroType.PROTEIN.rawValue].getMax()))
                        .font(.system(size: 12))
                }
                .foregroundColor(Color.gray)
            }
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

struct FoodListView: View {
    
    @State var foods: [Food]
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: -5) {
            ForEach(0 ..< foods.count) { i in
                var food = foods[i]
                
                HStack {
                    Image(systemName: "minus")
                        .frame(width: 20, height: 20)
                        .foregroundColor(.red)
                    Text(String(format: "\(food.name) %.1f\(food.unit.rawValue)", food.quantity))
                        .font(.system(size: 12))
                }
            }
        }
    }
}

struct BarGraph: View {
    
    @ObservedObject var event: FoodEvent
    
    @State var macros: [MacroData]
    
    var body: some View {
        VStack(alignment: .leading) {
            
            var cal = percentage(macroType: MacroType.CAL)
            var fat = percentage(macroType: MacroType.FAT)
            var carb = percentage(macroType: MacroType.CARB)
            var pro = percentage(macroType: MacroType.PROTEIN)
            
            Text(String(format: "%.1f%% Cal", cal))
                .font(.system(size: 12))
                .foregroundColor(cal > 90.0 ? Color.red : Color.gray)
            Text(String(format: "%.1f%% Fat", fat))
                .font(.system(size: 12))
                .foregroundColor(fat > 90.0 ? Color.red : Color.gray)
            Text(String(format: "%.1f%% Carb", carb))
                .font(.system(size: 12))
                .foregroundColor(carb > 90.0 ? Color.red : Color.gray)
            Text(String(format: "%.1f%% Pro", pro))
                .font(.system(size: 12))
                .foregroundColor(pro > 90.0 ? Color.red : Color.gray)
        }
    }
    
    private func percentage(macroType: MacroType) -> Float {
        
        return (event.totalMacroCount(macroType: macroType) / macros[macroType.rawValue].getMax())
    }
}
