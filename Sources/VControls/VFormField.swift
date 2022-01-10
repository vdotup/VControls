//
//  SwiftUIView.swift
//  
//
//  Created by Abdurrahman Alfudeghi on 07/01/2022.
//

import SwiftUI

public struct VFormField: View {
    
    var label: String
    var hint: String
    @Binding var text: String
    
    public init(_ label: String, text: Binding<String>, hint: String? = nil) {
        self.label = label
        self._text = text
        self.hint = hint ?? ""
    }
    
    public var body: some View {
        HStack {
            Text(label)
            TextField(hint, text: $text)
                .textFieldStyle(.plain)
                .multilineTextAlignment(.trailing)
        }
    }
}
