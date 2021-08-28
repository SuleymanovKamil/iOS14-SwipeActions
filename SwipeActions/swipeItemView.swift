//
//  swipeItemView.swift
//  SwipeActions
//
//  Created by Камиль Сулейманов on 28.08.2021.
//

import SwiftUI

struct SwipeItemView: View{
    
    var swipeItems: [SwipeItem]
    var swipeItemsHeight: CGFloat
    @Binding var horizontalOffset: CGFloat
    
    var body: some View{
        HStack(spacing: 0) {
            ForEach(swipeItems) { swipeItem in
                VStack(spacing: 10) {
                    Spacer()
                    
                    if swipeItem.image() != nil{
                        swipeItem.image()!
                            .resizable()
                            .scaledToFit()
                            .frame(height: swipeItem.itemWidth / 3)
                            
                    }
                    
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
        .frame(height: swipeItemsHeight)
      
    }
}
