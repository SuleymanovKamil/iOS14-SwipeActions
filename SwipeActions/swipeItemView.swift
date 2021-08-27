//
//  swipeItemView.swift
//  SwipeActions
//
//  Created by Камиль Сулейманов on 28.08.2021.
//

import SwiftUI

struct swipeItemView: View{
    var swipeItems: [SwipeItem]
    var height: CGFloat
    @Binding var horizontalOffset: CGFloat
    var body: some View{
        HStack(spacing: 0) {
            ForEach(swipeItems) { swipeItem in
                VStack(spacing: 10) {
                    Spacer()
                    
                    swipeItem.image()
                        .font(.title2)
                    
                    swipeItem.label()
                    
                    Spacer()
                }
                .frame(width: swipeItem.itemWidth)
                .background(swipeItem.itemColor)
                .onTapGesture {
                    swipeItem.action()
                    withAnimation{
                        horizontalOffset = 0
                    }
                }
            }
        }
        .frame(height: height)
        .zIndex(1)
        .clipped()
    }
}
