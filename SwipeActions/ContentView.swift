//
//  ContentView.swift
//  SwipeActions
//
//  Created by Камиль Сулейманов on 26.08.2021.
//

import SwiftUI

struct ContentView: View {
    var slots = [
        SwipeItem(image: {
            Image(systemName: "play")
        }, label: {
            Text("Play")
        }, action: {
            print(#function)
        }, itemColor: .yellow),
        SwipeItem(label: {
            Text("Play")
        }, action: {
            print(#function)
        }, itemColor: .blue)
    ]
    
    var body: some View {
        
        List (0...9, id: \.self){ number in
         
        
                Text(number.description)
             
            .swipeAction(leading: slots, trailing: [  SwipeItem(label: {
                Text("Play")
            }, action: {
                print(#function)
            }, itemColor: .green)], rowHeight: 80)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}










