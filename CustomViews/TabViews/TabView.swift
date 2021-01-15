import SwiftUI

struct CircleTabView: View {
    @ObservedObject var tabManager = TabManager(tabs: [])
    
    let width: CGFloat
    
    var body: some View {
        ZStack {

            HStack(spacing: width / (self.tabManager.tabs.count.cgFloat * 2.0)) {
                ForEach (self.tabManager.tabs) { tab in
                    TabItemView(tab: tab).onTapGesture {
                        self.tabManager.selectTab(index: tab.id)
                    }
                }
            }
        }.onAppear {
            for i in 0 ..< self.tabManager.tabs.count {
                self.tabManager.tabs[i].size = (height * 0.666);
            }
            tabManager.selectTab(index: 0)
        }
    }
}

/* Represents a single tab item view, actual image/text/etc. */
private struct TabItemView: View {
    
    let tab: TabItem
    
    var body: some View {
        Circle()
            .gradientForeground(colors: tab.selected ? [tab.leadingColor, tab.trailingColor] : [.gray, .gray])
            .frame(width: tab.size, height: tab.size)
    }
}
