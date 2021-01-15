import SwiftUI

struct ImageTabView: View {
    @ObservedObject var tabManager = ImageTabManager(tabs: [])
    
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack {
            HStack(spacing: width / (self.tabManager.tabs.count.cgFloat * 2.0)) {
                ForEach (self.tabManager.tabs) { tab in
                    ImageTabItemView(tab: tab).onTapGesture {
                        self.tabManager.selectTab(index: tab.id)
                    }
                }
            }
        }.onAppear {
            for i in 0 ..< self.tabManager.tabs.count {
                self.tabManager.tabs[i].frameSize = (height * 0.666);
            }
            tabManager.selectTab(index: 0)
        }
    }
}

/* Represents a single tab item view, actual image/text/etc. */
private struct ImageTabItemView: View {
    
    let tab: ImageTabItem
    
    var body: some View {
        Image(systemName: tab.imageName)
            .gradientForeground(colors: tab.selected ? [tab.leadingColor, tab.trailingColor] : [.gray, .gray])
    }
}
