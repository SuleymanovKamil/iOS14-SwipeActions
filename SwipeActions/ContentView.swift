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
         
                Text("1")
            .swipeAction(trailing:
        [SwipeItem(label: {
                Text("Play")
            }, action: {
                print("Play")
            }, itemWidth: 80
            , itemColor: .yellow)], rowHeight: 40)
            
            
            Text("2")
                .swipeAction(leading: swipeItems, trailing: swipeItems2, rowHeight: 80)
            
            Text("3")
        .swipeAction(leading:
    [SwipeItem(label: {
            Text("Play")
        }, action: {
            print("Play")
        }, itemWidth: 80
        , itemColor: .yellow)], rowHeight: 40)
            
        }
        .padding(.horizontal, -20)
    }
    
    var swipeItems = [
        SwipeItem(image: {
            Image(systemName: "play")
        }, label: {
            Text("Play")
        }, action: {
            print("Play")
        }, itemWidth: 80
        , itemColor: .yellow),
    
        
        SwipeItem(label: {
            Text("Pause")
        }, action: {
            print("Pause")
        }, itemColor: .blue),
        
        SwipeItem(image: {
            Image(systemName: "play")
        }, label: {
            Text("Play")
        }, action: {
            print("Play")
        }, itemColor: .purple)
    ]
    
    var swipeItems2 = [
        SwipeItem(image: {
            Image(systemName: "play")
        }, label: {
            Text("Play")
        }, action: {
            print("Play")
        }, itemColor: .blue),
        
        SwipeItem(label: {
            Text("Pause")
        }, action: {
            print("Pause")
        }, itemColor: .gray),
        
       
    ]
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}










