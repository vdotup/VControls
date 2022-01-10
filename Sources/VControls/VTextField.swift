//
//  VTextField.swift
//  FirebaseDemo-SwiftUI
//
//  Created by Abdurrahman Alfudeghi on 07/01/2022.
//

import SwiftUI

public struct VTextField: View {
    
    @FocusState var focused: Bool
    @Binding var text: String
    @ObservedObject private var data = VData()
    
    public init(_ text: Binding<String>) {
        self._text = text
    }
    
    public var body: some View {
        ZStack {
            HStack(spacing: 0) {
                if data.secure {
                    SecureField(data.title, text: $text)
                        .textFieldStyle(.plain)
                        .foregroundColor(data.textColor)
                        .focused($focused)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                } else {
                    TextField(data.title, text: $text)
                        .textFieldStyle(.plain)
                        .foregroundColor(data.textColor)
                        .focused($focused)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                }
                
                
                if data.validator != nil {
                    Image(systemName: data.valid ? "checkmark" : "xmark")
                        .foregroundColor(data.valid ? .green : .red)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: data.cornerRadius, style: .circular)
                .foregroundColor(data.isFocused ? data.focusedBackgroundColor : data.backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: data.cornerRadius, style: .circular)
                        .stroke(data.borderColor, lineWidth: data.borderLineWidth)
                )
        )
        .onChange(of: focused) { newValue in
            withAnimation {
                data.isFocused = newValue
            }
        }
        .onChange(of: text, perform: { newValue in
            validate()
        })
        .contentShape(RoundedRectangle(cornerRadius: data.cornerRadius, style: .circular))
        .onTapGesture {
            focused = true
        }
        
    }
}

extension VTextField {
    
    public enum ValidationOption: CaseIterable, Hashable {
        case email
        case password
        case noSpaces
        case notEmpty
        
        public var value: String {
            switch self {
            case .email: return "email"
            case .password: return "password"
            case .noSpaces: return "noSpaces"
            case .notEmpty: return "notEmpty"
            }
        }
    }
    
    private func validate() {
        guard data.validator != nil
        else { return }
        DispatchQueue.main.async {
            withAnimation {
                data.valid = validation()
                data.validator?.wrappedValue = data.valid
            }
        }
    }
    
    private func validation() -> Bool {
        guard let options = data.validationOptions else { return false }
        var validOptions: [Bool] = []
        for option in options {
            switch option {
            case .email:
                let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
                validOptions.append(emailPred.evaluate(with: text))
            case .password:
                guard
                    text.count >= 6
                else { validOptions.append(false); continue }
                validOptions.append(true)
            case .noSpaces:
                validOptions.append(!text.contains(" "))
            case .notEmpty:
                validOptions.append(!text.isEmpty)
            }
        }
        return !validOptions.contains(false)
    }
    
    class VData: ObservableObject {
        
        @Published fileprivate var isFocused: Bool = false
        @Published fileprivate var valid: Bool = false
        
        @Published var title: String = ""
        
        @Published var textColor: Color = .black
        @Published var backgroundColor: Color = .init(uiColor: .systemGray6)
        @Published var focusedBackgroundColor: Color = .init(uiColor: .systemGray4)
        @Published var borderColor: Color = .init(uiColor: .systemGray)
        
        @Published var borderLineWidth: CGFloat = 1
        @Published var cornerRadius: CGFloat = 8
        
        @Published var secure: Bool = false
        
        @Published var validator: Binding<Bool>?
        @Published var validationOptions: [ValidationOption]?
    }
    
    public func title(_ title: String) -> Self {
        self.data.title = title
        return self
    }
    
    public func textColor(_ textColor: Color) -> Self {
        self.data.textColor = textColor
        return self
    }
    
    public func backgroundColor(_ backgroundColor: Color) -> Self {
        self.data.backgroundColor = backgroundColor
        return self
    }
    
    public func focusedBackgroundColor(_ focusedBackgroundColor: Color) -> Self {
        self.data.focusedBackgroundColor = focusedBackgroundColor
        return self
    }
    
    public func borderColor(_ borderColor: Color) -> Self {
        self.data.borderColor = borderColor
        return self
    }
    
    public func borderLineWidth(_ borderLineWidth: CGFloat) -> Self {
        self.data.borderLineWidth = borderLineWidth
        return self
    }
    
    public func cornerRadius(_ cornerRadius: CGFloat) -> Self {
        self.data.cornerRadius = cornerRadius
        return self
    }
    
    public func secure(_ secure: Bool = true) -> Self {
        self.data.secure = secure
        return self
    }
    
    public func validation(_ validator: Binding<Bool>?, options: [ValidationOption]) -> Self {
        if options.isEmpty || validator == nil { return self }
        self.data.validator = validator
        self.data.validationOptions = options
        self.validate()
        return self
    }
    
}

struct VTextField_Previews: PreviewProvider {
    static var previews: some View {
        VTextField(.constant("text"))
    }
}
