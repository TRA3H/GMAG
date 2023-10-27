import SwiftUI

struct WorkoutSplitView: View {
    @State private var scrollOffset: CGFloat = 0
    private let cardWidth: CGFloat = 250
    private let cardHeight: CGFloat = 500
    private let spacing: CGFloat = 30
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: spacing) {
                    ForEach(DayOfWeek.allCases, id: \.self) { day in
                        GeometryReader { geometry in
                            Text(day.rawValue)
                                .frame(width: cardWidth, height: cardHeight)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                                .zIndex(self.zIndex(for: geometry.frame(in: .global).minX, in: fullView.size.width))
                        }
                        .frame(width: cardWidth, height: cardHeight)
                    }
                }
                .padding(.horizontal, (fullView.size.width - cardWidth) / 2)
                .offset(x: self.scrollOffset)
                .gesture(DragGesture().onEnded { value in
                    self.handleScrollEnd(with: fullView.size)
                })
            }
            .frame(width: fullView.size.width, height: cardHeight, alignment: .center)
            .position(x: fullView.size.width / 2, y: fullView.size.height / 2)
        }
    }
    
    func zIndex(for cardPosition: CGFloat, in fullViewWidth: CGFloat) -> Double {
        let relativePosition = cardPosition - (fullViewWidth / 2) + (cardWidth / 2)
        return relativePosition < 0 ? 0 : 1
    }
    
    func handleScrollEnd(with fullViewSize: CGSize) {
        let approximateCardWidth = cardWidth + spacing
        let offset = scrollOffset + approximateCardWidth / 2 + fullViewSize.width / 2
        let cardIndex = round(offset / approximateCardWidth)
        
        withAnimation {
            self.scrollOffset = cardIndex * -approximateCardWidth
        }
    }
}

enum DayOfWeek: String, CaseIterable {
    case Mon, Tue, Wed, Thu, Fri, Sat, Sun
}

struct WorkoutSplitView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutSplitView()
    }
}
