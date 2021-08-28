//
//  ContentView.swift
//  SwipeActions
//
//  Created by Камиль Сулейманов on 26.08.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        List {
            VStack {
                Text("Trailing action")
                .swipeAction(trailing: [SwipeItem(
                                            label: { Text("Action")},
                                            action: { print("Action") },
                                            itemWidth: 80,
                                            itemColor: .yellow)],
                         rowHeight: 40)
            }
            
            Text("Both sides actions")
                .swipeAction(leading: swipeItems, trailing: swipeItems2, rowHeight: 80)
            
            Text("Leading actions")
                .swipeAction(leading: [SwipeItem(
                                        label: { Text("Play")},
                                        action: { print("Play")},
                                        itemWidth: 80,
                                        itemColor: .yellow)],
                                        rowHeight: 40)
        }
        .padding(.horizontal, -20) //to remove list horizontal padding, or need to use ForEach with .listRowInsets(EdgeInsets())
    }
    
    
    var swipeItems = [
        SwipeItem(image: { Image(systemName: "play")},
                  label: { Text("Play") },
                  action: { print("Play")},
                  itemWidth: 80 ,
                  itemColor: .yellow),
        
        SwipeItem(label: { Text("Pause")},
                  action: { print("Pause") },
                  itemColor: .blue),
        
        SwipeItem(image: {
            Image("whatsappIcon")},
                  label: { Text("Whatsapp")
                            .font(.caption)
                            .foregroundColor(.white)},
                  action: { print("Whatsapp")},
                  itemColor: .green) ]
    
    var swipeItems2 = [
        SwipeItem(image: { Image(systemName: "pencil.circle.fill")},
                  label: { Text("Edit") },
                  action: { print("Edit")},
                  itemColor: .yellow),
        
        SwipeItem(image: { Image(systemName: "trash.circle.fill").renderingMode(.original)},
                  label: { Text("Delete").foregroundColor(.white).font(.caption2) },
                  action: { print("Delete") },
                  itemColor: .red), ]
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}










