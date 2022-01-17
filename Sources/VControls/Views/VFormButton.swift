//
//  SwiftUIView.swift
//  
//
//  Created by Abdurrahman Alfudeghi on 12/01/2022.
//

import SwiftUI

public struct VFormButton: View {
    
    @Environment(\.isEnabled) var isEnabled: Bool
    @State private var isPressed: Bool = false
    let backgroundColor: Color?
    let textColor: Color?
    
    public init(backgroundColor: Color? = .blue, textColor: Color? = .red) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor
    }
    
    public var body: some View {
        Button("Form Button", action: {})
            .buttonStyle(ListButtonStyle(isPressed: $isPressed, textColor: textColor))
            .listRowBackground(isEnabled ? (isPressed ? backgroundColor?.opacity(0.5) : backgroundColor) : Color.gray )
    }
    
    private struct ListButtonStyle: ButtonStyle {
        
        @Binding private var isPressed: Bool
        var textColor: Color?
        
        public init(isPressed: Binding<Bool>, textColor: Color? = .red) {
            self._isPressed = isPressed
            self.textColor = textColor
        }
        
        public func makeBody(configuration: Self.Configuration) -> some View {
            MyButton(configuration: configuration, textColor: textColor)
                .onChange(of: configuration.isPressed) { newValue in
                    isPressed = newValue
                }
        }
        
        public struct MyButton: View {
            
            @Environment(\.isEnabled) var isEnabled: Bool
            let configuration: ButtonStyle.Configuration
            let textColor: Color?
            
            public init(configuration: ButtonStyle.Configuration, textColor: Color? = .red) {
                self.configuration = configuration
                self.textColor = textColor
            }
            
            public var body: some View {
                configuration.label
                    .font(.headline)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .contentShape(Rectangle())
                    .foregroundColor(configuration.isPressed ? textColor?.opacity(0.5) : textColor)
            }
            
        }
    }
    
}
