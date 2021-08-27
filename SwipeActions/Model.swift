//
//  Model.swift
//  SwipeActions
//
//  Created by Камиль Сулейманов on 27.08.2021.
//

import SwiftUI

struct SwipeItem: Identifiable{
     let id = UUID()
     let image: () -> Image?
     let label: () -> Text?
     let action: () -> Void
     let itemWidth: CGFloat
     let itemColor: Color
    
     init(
        image: @escaping () -> Image? = { nil },
        label : @escaping () -> Text? = { nil },
        action: @escaping () -> Void,
        itemWidth : CGFloat = 80,
        itemColor: Color
    ) {
        self.image = image
        self.label = label
        self.action = action
        self.itemWidth = itemWidth
        self.itemColor = itemColor
    }
    
}


