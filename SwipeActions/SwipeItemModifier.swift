//
//  SwipeItemModifier.swift
//  SwipeActions
//
//  Created by Камиль Сулейманов on 27.08.2021.
//

import SwiftUI

struct SwipeActions: ViewModifier {
    
    enum SwipeSide {
        case leftSwipe
        case rightSwipe
    }
    
    private var contentOffset: CGFloat {
        switch swipeDirection {
        case .leftSwipe:
            return swipeItemWidth
        case .rightSwipe:
            return -swipeItemWidth
        }
    }
    
    private var swipeItemOffset: CGFloat {
        switch swipeDirection {
        case .leftSwipe:
            return swipeItemWidth - totalSwipeItemWidth
        case .rightSwipe:
            return totalSwipeItemWidth - swipeItemWidth
        }
    }
    
    private var zStackAlignment: Alignment {
        switch swipeDirection {
        case .leftSwipe:
            return .leading
        case .rightSwipe:
            return .trailing
        }
    }
    
    @State var swipeItemWidth: CGFloat = 0
    
    private func optWidth(value: CGFloat) -> CGFloat {
        return min(abs(value), totalSwipeItemWidth)
    }
    
    private var totalSwipeItemWidth: CGFloat {
        return swipeItems.map { $0.itemWidth}.reduce(0, +)
    }
    
    private var swipeItems: [SwipeItem] {
        swipeDirection == .leftSwipe ? leadingSwipeItems : trailingSwipeitems
    }
    
    @State private var swipeDirection: SwipeSide = SwipeSide.leftSwipe
    private var leadingSwipeItems: [SwipeItem]
    private var trailingSwipeitems: [SwipeItem]
    private var rowHeight: CGFloat
    
    init(leading: [SwipeItem], trailing: [SwipeItem], rowHeight: CGFloat ) {
        leadingSwipeItems = leading
        trailingSwipeitems = trailing
        self.rowHeight = rowHeight
    }
    
    private func resetOffsetState() {
        withAnimation {
            swipeItemWidth = 0
        }
    }
    
    func body(content: Content) -> some View {
        
        ZStack {
            GeometryReader { geo in
                HStack{
                    content
                        .frame(height: rowHeight)
                        .frame(width: geo.size.width)
                        .background(Color.red)
                        .offset(x: contentOffset)
                    
                    
                    swipeItemView
                        .offset(x: -swipeItemOffset)
                        .frame(width: totalSwipeItemWidth)
                        .zIndex(1)
                }
            }
            
        }
        .frame(height: rowHeight)
        .clipShape(Rectangle())
        .gesture(dragGesture)
        .clipped()
    }
    
 
    private var swipeItemView: some View {
        HStack(spacing: 0) {
            ForEach(swipeItems) { swipeItem in
                VStack(spacing: 10) {
                    Spacer() // To extend top edge
                    
                    swipeItem.image()
                        .font(.title2)
                    
                    swipeItem.label()
                    
                    
                    Spacer() // To extend bottom edge
                }
                .frame(width: swipeItem.itemWidth)
                .background(swipeItem.itemColor)
                .onTapGesture {
                    swipeItem.action()
                    resetOffsetState()
                }
            }
        }
        .frame(height: rowHeight)
        
    }
    
    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 30, coordinateSpace: .local)
            .onChanged { value in
                
                withAnimation {
                    if value.translation.width > 0 && contentOffset < 0 {
                        swipeDirection = .leftSwipe
                    } else {
                        swipeDirection = .rightSwipe
                    }

                    swipeItemWidth =  optWidth(value: value.translation.width)
                }
            }
            .onEnded { value in
                withAnimation {
                    if swipeItemWidth < (totalSwipeItemWidth / 2) {
                        swipeItemWidth = 0
                    } else {
                        swipeItemWidth = totalSwipeItemWidth
                    }
                }
            }
    }
    
}


extension View {
    func swipeAction(leading: [SwipeItem] = [], trailing: [SwipeItem] = [], rowHeight: CGFloat) -> some View {
        return modifier(SwipeActions(leading: leading, trailing: trailing, rowHeight: rowHeight))
    }
}

struct SwipeItemModifier_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
