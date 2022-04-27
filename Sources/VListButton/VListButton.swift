//
//  SwiftUIView.swift
//  
//
//  Created by Abdurrahman Alfudeghi on 12/01/2022.
//

import SwiftUI

public struct VListButton: View {
    
    @Environment(\.isEnabled) var isEnabled: Bool
    @ObservedObject private var data = VData()
    
    var title: String
    var action: () -> Void
    
    public init(_ titleKey: String, action: @escaping () -> Void) {
        self.title = titleKey
        self.action = action
    }
    
    public var body: some View {
        Button(title, action: action)
        .buttonStyle(ListButtonStyle(data: data))
        .listRowBackground(getBackgroundColor())
    }
    
    private func getBackgroundColor() -> Color {
        if isEnabled {
            if data.isPressed {
                return data.tappedBackgroundColor == .clear ? data.backgroundColor.opacity(0.5) : data.tappedBackgroundColor
            } else {
                return data.backgroundColor
            }
        } else {
            return data.disabledBackgroundColor
        }
    }
    
    private struct ListButtonStyle: ButtonStyle {
        
        var data: VData
        
        public init(data: VData) {
            self.data = data
        }
        
        public func makeBody(configuration: Self.Configuration) -> some View {
            MyButton(configuration: configuration, data: data)
                .onChange(of: configuration.isPressed) { newValue in
                    data.isPressed = newValue
                }
        }
        
        public struct MyButton: View {
            
            @Environment(\.isEnabled) var isEnabled: Bool
            let configuration: ButtonStyle.Configuration
            var data: VData
            
            public init(configuration: ButtonStyle.Configuration, data: VData) {
                self.configuration = configuration
                self.data = data
            }
            
            public var body: some View {
                configuration.label
                    .font(.headline)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .contentShape(Rectangle())
                    .foregroundColor(getTextColor())
            }
            
            private func getTextColor() -> Color {
                if isEnabled {
                    if configuration.isPressed {
                        return data.tappedTextColor == .clear ? data.textColor.opacity(0.5) : data.tappedTextColor
                    } else {
                        return data.textColor
                    }
                } else {
                    return data.disabledTextColor == .clear ? data.textColor.opacity(0.5) : data.disabledTextColor
                }
                
            }
            
        }
    }
    
}


extension VListButton {
    
    class VData: ObservableObject {
        
        @Published var isPressed: Bool = false
        
        @Published var textColor: Color = .white
        @Published var tappedTextColor: Color = .clear
        @Published var disabledTextColor: Color = .clear
        
        // - background Color
        @Published var backgroundColor: Color = .blue
        @Published var tappedBackgroundColor: Color = .clear
        @Published var disabledBackgroundColor: Color = .gray
    }
    
    /// Text color.
    public func textColor(_ textColor: Color) -> Self {
        self.data.textColor = textColor
        return self
    }
    
    /// Tapped Text color.
    public func tappedTextColor(_ tappedTextColor: Color) -> Self {
        self.data.tappedTextColor = tappedTextColor
        return self
    }
    
    /// Disabled Text color.
    public func disabledTextColor(_ disabledTextColor: Color) -> Self {
        self.data.disabledTextColor = disabledTextColor
        return self
    }
    
    /// Background color.
    public func backgroundColor(_ backgroundColor: Color) -> Self {
        self.data.backgroundColor = backgroundColor
        return self
    }
    
    public func tappedBackgroundColor(_ tappedBackgroundColor: Color) -> Self {
        self.data.tappedBackgroundColor = tappedBackgroundColor
        return self
    }
    
    public func disabledBackgroundColor(_ disabledBackgroundColor: Color) -> Self {
        self.data.disabledBackgroundColor = disabledBackgroundColor
        return self
    }
    
}
