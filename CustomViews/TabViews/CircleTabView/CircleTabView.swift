import SwiftUI

struct CircleTabView: View {
    @ObservedObject var tabManager = CircleTabManager(tabs: [])
    
    let width: CGFloat
    
    var body: some View {
        ZStack {
            HStack(spacing: width / (self.tabManager.tabs.count.cgFloat * 2.0)) {
                ForEach (self.tabManager.tabs) { tab in
                    CircleTabItemView(tab: tab).onTapGesture {
                        self.tabManager.selectTab(index: tab.id)
                    }
                }
            }
        }.onAppear {
            tabManager.selectTab(index: 0)
        }
    }
}

/* Represents a single tab item view, actual image/text/etc. */
private struct CircleTabItemView: View {
    
    let tab: CircleTabItem
    
    var body: some View {
        Circle()
            .gradientForeground(colors: tab.selected ? [tab.leadingColor, tab.trailingColor] : [.gray, .gray])
            .frame(width: tab.size, height: tab.size)
    }
}
