//
//  SwiftUIView.swift
//  
//
//  Created by Abdurrahman Alfudeghi on 15/01/2022.
//

import SwiftUI

public struct VFormPicker: View {
    
    @State private var tapped: Bool = true
    @State private var selection: Int = 0
    
    public init() {
        
    }
    
    public var body: some View {
        ZStack {
            HStack {
                Text("item \(selection)")
                Spacer()
                Image(systemName: tapped ? "arrow.up" : "arrow.down")
            }
            .padding()
            .frame(width: 200, height: 50)
            .background(.gray)
            //.cornerRadius(10)
            .cornerRadius(10, corners: tapped ? [.topLeft, .topRight] : [.allCorners])
            .onTapGesture {
                tapped.toggle()
            }
            
            
            if tapped {
                VStack() {
                    ScrollView {
                        ForEach(0..<10) { i in
                            Text("item \(i)")
                                .frame(maxWidth: .infinity)
                                .onTapGesture {
                                    select(item: i)
                                }
                        }
                    }
                }
                .frame(width: 200, height: 100)
                .background(.green)
                .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                .offset(x: 0, y: 75)
            }
        }
        .position(x: 0, y: 0)
        
    }
    
    private func select(item: Int) {
        tapped.toggle()
        selection = item
    }
}

struct VFormPicker_Previews: PreviewProvider {
    static var previews: some View {
        VFormPicker()
    }
}
