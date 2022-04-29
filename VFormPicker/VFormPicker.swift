//
//  SwiftUIView.swift
//  
//
//  Created by Abdurrahman Alfudeghi on 15/01/2022.
//

import SwiftUI
import RoundedCorner

public struct VFormPicker: View {
    
    @State private var tapped: Bool = false
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
            .cornerRadius(10, corners: tapped ? [.topLeft, .topRight] : [.allCorners])
            .onTapGesture {
                tapped.toggle()
            }
        }
        .popup(isPresented: $tapped) {
            ZStack {
                Color.green
                Button("dismiss", action: {tapped.toggle()})
            }
            .frame(width: 200, height: 200, alignment: .center)
        }


        
        
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
