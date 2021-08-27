//
//  ViewBuilderSwipe.swift
//  SwipeActions
//
//  Created by Камиль Сулейманов on 27.08.2021.
//

import SwiftUI


struct swipeView: View {
    
    var body: some View {
        SwipeView(content: {
            Text("SwipeView")
        }, leftSide: {
            Image(systemName: "play")
        }, rightSide: {
            Image(systemName: "pause")
        }, swipeViewHeight: 100)
    }

}
struct SwipeView<Content: View, LeftSide: View, RightSide: View>: View {
    var content: Content
    var leftSide: LeftSide
    var rightSide: RightSide
    var swipeViewHeight: CGFloat
    
    @State var horizontalOffset: CGFloat = 0
    @State var contentOffset: CGFloat = 0
    
    let screenWidth = UIScreen.main.bounds.width
    var contentOffsetOnSwipe: CGFloat { screenWidth / 3 }
    var swipeRecognitionValue: CGFloat { screenWidth / 15 }
    
    @State var leftSwipe: Bool?
    @State var rightSwipe = false
    
    init (@ViewBuilder content: @escaping () -> Content,
                      @ViewBuilder leftSide: @escaping () -> LeftSide,
                       @ViewBuilder rightSide: @escaping () -> RightSide,
                      swipeViewHeight: CGFloat,
                      leftSwipe: Bool = false) {
        self.content = content()
        self.leftSide = leftSide()
        self.rightSide = rightSide()
        self.swipeViewHeight = swipeViewHeight
    }
    
    init (@ViewBuilder content: @escaping () -> Content,
                      @ViewBuilder leftSide: @escaping () -> LeftSide,
                      swipeViewHeight: CGFloat
    ) where RightSide == EmptyView  {
        self.init(content: content, leftSide: leftSide, rightSide: { EmptyView() }, swipeViewHeight: swipeViewHeight)
    }
    
    
    
    var drag: some Gesture {
        DragGesture(minimumDistance: 30, coordinateSpace: .local)
            .onChanged { value in
               
                withAnimation {
                    
                    horizontalOffset = contentOffset + value.translation.width
                    
                    if abs(horizontalOffset) > contentOffsetOnSwipe {
                        
                        if rightSwipe  {
                            horizontalOffset = -contentOffsetOnSwipe
                        } else if leftSwipe != nil {
                            horizontalOffset = contentOffsetOnSwipe
                        }
   
                    }
                    
                    if contentOffset > 0 && leftSwipe != nil {
                        leftSwipe = horizontalOffset > contentOffsetOnSwipe - swipeRecognitionValue
                    } else if leftSwipe != nil {
                        leftSwipe = horizontalOffset > swipeRecognitionValue
                    }
                    
                    if contentOffset < 0 {
                        rightSwipe = horizontalOffset < -contentOffsetOnSwipe + swipeRecognitionValue
                    } else {
                        rightSwipe = horizontalOffset < -swipeRecognitionValue
                    }
                }
            }
            .onEnded { value in
                withAnimation {
                    if rightSwipe {
                        contentOffset = -contentOffsetOnSwipe
                    } else if leftSwipe != nil {
                        contentOffset = contentOffsetOnSwipe
                    } else {
                        contentOffset = 0
                    }
                    
                    horizontalOffset = contentOffset
                }
            }
    }
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 0) {
                leftSide
                    .frame(width: contentOffsetOnSwipe)
                    .zIndex(1)
                    .clipped()
                
                content
                    .frame(width: geo.size.width)
                    .zIndex(0)
                
                rightSide
                    .frame(width: contentOffsetOnSwipe)
                    .zIndex(1)
                    .clipped()
            }
        }
        .offset(x: -contentOffsetOnSwipe + horizontalOffset)
        .frame(height: swipeViewHeight)
        .contentShape(Rectangle())
        .gesture(drag)
        .clipped()
    }
}



