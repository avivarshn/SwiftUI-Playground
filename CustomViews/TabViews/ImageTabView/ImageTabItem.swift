import SwiftUI

/*  Stores a Tabs information. Create instances of this object to create "Tab" objects.
    Tab's color is always a LinearGradient.
 */
struct ImageTabItem: Identifiable {
    // Unique ID.
    let id: Int
    // Must be a system image name.
    let imageName: String
    // Starting color for button.
    var leadingColor: Color = UIColor.systemTeal.color
    // Trailing color for button.
    var trailingColor: Color = Color.blue
    // Size of image.
    var frameSize: CGFloat = 40.0
    // "State" of Tab, whether or not it is currently selected.
    var selected: Bool = false
}
