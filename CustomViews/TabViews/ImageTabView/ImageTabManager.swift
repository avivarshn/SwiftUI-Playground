import SwiftUI

/* Contains methods to change selected tab. */
class ImageTabManager: ObservableObject {
    @Published var tabs: [ImageTabItem] = []
    @Published var lastSelectedIndex = -1
    
    init(tabs: [ImageTabItem]) {
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
