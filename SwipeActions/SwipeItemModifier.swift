//
//  SwipeItemModifier.swift
//  SwipeActions
//
//  Created by Камиль Сулейманов on 27.08.2021.
//

import SwiftUI

struct SwipeActions: ViewModifier {
    private var leadingSwipeItems: [SwipeItem]
    private var trailingSwipeitems: [SwipeItem]
    private var rowHeight: CGFloat
    
    @State private var horizontalOffset: CGFloat = 0
    @State private var contentOffset: CGFloat = 0
    
    @State private var isLeftSwipe = false
    @State private var isRightSwipe = false
    
    let screenWidth = UIScreen.main.bounds.width
    private  var contentOffsetOnSwipe: CGFloat { screenWidth / 3 }
    private var swipeRecognitionValue: CGFloat { screenWidth / 15 }
    
    private func totalSwipeItemWidth (for array: [SwipeItem]) -> CGFloat {
        return array.map { $0.itemWidth}.reduce(0, +)
    }
    
    init(leading: [SwipeItem], trailing: [SwipeItem], rowHeight: CGFloat ) {
        leadingSwipeItems = leading
        trailingSwipeitems = trailing
        self.rowHeight = rowHeight
    }
    
    func body(content: Content) -> some View {
        
        ZStack {
            GeometryReader { geo in
                HStack {
                    
                    swipeItemView(swipeItems: leadingSwipeItems,
                                  height: rowHeight,
                                  horizontalOffset: $horizontalOffset)
                      
                    content
                        .frame(width: geo.size.width)
                        .zIndex(0)
                    
                    
                    swipeItemView(swipeItems: trailingSwipeitems,
                                  height: rowHeight,
                                  horizontalOffset: $horizontalOffset)
                }
            }
            .offset(x: -totalSwipeItemWidth(for: leadingSwipeItems) + horizontalOffset)
            .frame(height: rowHeight)
            .contentShape(Rectangle())
            .gesture(dragGesture)
            .clipped()
        }
        
    }
    
    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 30, coordinateSpace: .local)
            .onChanged { value in
                
                withAnimation {
                    
                    if !leadingSwipeItems.isEmpty && value.translation.width > 0{
                    horizontalOffset = contentOffset + value.translation.width
                    }
                    
                    if !trailingSwipeitems.isEmpty && value.translation.width < 0 {
                    horizontalOffset = contentOffset + value.translation.width
                    }
                    
                    if contentOffset > 0 {
                        isLeftSwipe = horizontalOffset > contentOffsetOnSwipe - swipeRecognitionValue
                    } else {
                        isLeftSwipe = horizontalOffset > swipeRecognitionValue
                    }
                    
                    if contentOffset < 0 {
                        isRightSwipe = horizontalOffset < -contentOffsetOnSwipe + swipeRecognitionValue
                    } else {
                        isRightSwipe = horizontalOffset < -swipeRecognitionValue
                    }
                    
                    if abs(horizontalOffset) > contentOffsetOnSwipe {
                        if isLeftSwipe  {
                            horizontalOffset = contentOffsetOnSwipe
                        } else if isRightSwipe  {
                            horizontalOffset = -contentOffsetOnSwipe
                        }
                    }
                }
            }
            .onEnded { value in
                withAnimation {
                    if isRightSwipe {
                        contentOffset = -totalSwipeItemWidth(for: trailingSwipeitems) - CGFloat(trailingSwipeitems.count * 5)
                    } else if isLeftSwipe {
                        contentOffset = totalSwipeItemWidth(for: leadingSwipeItems)
                    } else {
                        contentOffset = 0
                    }
                    horizontalOffset = contentOffset
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



