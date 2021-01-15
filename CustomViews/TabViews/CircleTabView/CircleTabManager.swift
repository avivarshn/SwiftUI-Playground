import SwiftUI

/* Contains methods to change selected tab. */
class CircleTabManager: ObservableObject {
    @Published var tabs: [CircleTabItem] = []
    @Published var lastSelectedIndex = -1
    
    init(tabs: [CircleTabItem]) {
        self.tabs = tabs
    }
    
    func selectTab(index: Int) {
        if index != self.lastSelectedIndex {
            self.tabs[index].selected = true
            
            if lastSelectedIndex != -1 {
                self.tabs[lastSelectedIndex].selected = false
            }
            self.lastSelectedIndex = index
        }
    }
}
