import SwiftUI

extension Color {
    static let macroBarWaterBackgroundColor = Color(UIColor.systemTeal)
    static let macroBarWaterStartColor = macroBarWaterBackgroundColor
    static let macroBarWaterEndColor = Color.blue
    static let macroBarFatsBackgroundColor = Color.yellow
    static let macroBarFatsStartColor = macroBarFatsBackgroundColor
    static let macroBarFatsEndColor = Color.orange
    static let macroBarCarbsBackgroundColor = Color.orange
    static let macroBarCarbsStartColor = macroBarCarbsBackgroundColor
    static let macroBarCarbsEndColor = Color.red
    static let macroBarProteinsBackgroundColor = Color(UIColor.systemTeal)
    static let macroBarProteinsStartColor = macroBarProteinsBackgroundColor
    static let macroBarProteinsEndColor = Color.green
    
    static let foodColor = Color.orange
    static let waterColor = Color.blue
    static let meditationColor = Color.pink
    static let exerciseColor = Color.green
    static let notesColor = Color.purple
}

extension UIColor {
    var color: Color { return Color(self) }
}
