//
//  File.swift
//  SwipeActions
//
//  Created by Камиль Сулейманов on 27.08.2021.
//

import Foundation

//struct SwipeActions: ViewModifier {
//   
//    enum SwipeSide {
//       case leftSwipe
//       case rightSwipe
//   }
//   
//   private var contentOffset: CGFloat {
//       switch swipeDirection {
//       case .leftSwipe:
//           return currentSlotsWidth
//       case .rightSwipe:
//           return -currentSlotsWidth
//       }
//   }
//   
//   private var swipeItemOffset: CGSize {
//       switch swipeDirection {
//       case .leftSwipe:
//           return .init(width: currentSlotsWidth - totalSlotWidth, height: 0)
//       case .rightSwipe:
//           return .init(width: totalSlotWidth - currentSlotsWidth, height: 0)
//       }
//   }
//   
//   private var zStackAlignment: Alignment {
//       switch swipeDirection {
//       case .leftSwipe:
//           return .leading
//       case .rightSwipe:
//           return .trailing
//       }
//   }
//   
//   /// Animated slot widths of total
//   @State var currentSlotsWidth: CGFloat = 0
//   
//   /// To restrict the bounds of slots
//   private func optWidth(value: CGFloat) -> CGFloat {
//       return min(abs(value), totalSlotWidth)
//   }
//  
//   private var totalSlotWidth: CGFloat {
//       return slots.map { $0.itemWidth}.reduce(0, +)
//   }
//   
//   private var slots: [SwipeItem] {
//       swipeDirection == .leftSwipe ? leadingSlots : trailingSlots
//   }
//   
//   @State private var swipeDirection: SwipeSide = SwipeSide.leftSwipe
//   private var leadingSlots: [SwipeItem]
//   private var trailingSlots: [SwipeItem]
//   
//   init(leading: [SwipeItem], trailing: [SwipeItem]) {
//       leadingSlots = leading
//       trailingSlots = trailing
//   }
//   
//   private func flushState() {
//       withAnimation {
//           currentSlotsWidth = 0
//       }
//   }
//   
//    func body(content: Content) -> some View {
//       
//       ZStack(alignment: zStackAlignment) {
//           
//           content
//               .offset(x: contentOffset)
//
//           if !currentSlotsWidth.isZero {
//               Rectangle()
//               .foregroundColor(.white)
//               .opacity(0.001)
//               .onTapGesture(perform: flushState)
//           }
//
//           slotContainer
//           .offset(swipeItemOffset)
//           .frame(width: totalSlotWidth)
//           
//       }
//       .frame(height: 80)
//       .clipShape(Rectangle())
//       .gesture(dragGesture)
//       .clipped()
//   }
//   
//   // MARK: Slot Container
//   private var slotContainer: some View {
//       HStack(spacing: 0) {
//           
//           ForEach(slots) { slot in
//               VStack(spacing: 10) {
//                   Spacer() // To extend top edge
//                   
//                   slot.image()
//                       .font(.title2)
//                   
//                   slot.label()
//                    
//                   
//                   Spacer() // To extend bottom edge
//               }
//               .frame(width: slot.itemWidth)
//               .background(slot.itemColor)
//               .onTapGesture {
//                   slot.action()
//                   flushState()
//               }
//           }
//       }
//   }
//
//   private var dragGesture: some Gesture {
//       DragGesture()
//           .onChanged { value in
//               let amount = value.translation.width
//               
//               if amount < 0 {
//                   swipeDirection = .rightSwipe
//               } else {
//                   swipeDirection = .leftSwipe
//               }
//               
//               currentSlotsWidth = optWidth(value: amount)
//           }
//           .onEnded { value in
//               withAnimation {
//                   if currentSlotsWidth < (totalSlotWidth / 2) {
//                       currentSlotsWidth = 0
//                   } else {
//                       currentSlotsWidth = totalSlotWidth
//                   }
//               }
//           }
//   }
//   
//}

//extension View {
//   
//   func swipeAction(leading: [SwipeItem] = [], trailing: [SwipeItem] = []) -> some View {
//       return modifier(SwipeActions(leading: leading, trailing: trailing))
//   }
//  
//}
//
//struct SwipeItemModifier_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
