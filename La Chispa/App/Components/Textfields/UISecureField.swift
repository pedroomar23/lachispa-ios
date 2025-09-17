//
//  UISecureField.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import UIKit
import SwiftUI

struct MultiSecureField : UIViewRepresentable {
    typealias UIViewType = UITextField
    
    @Binding var text : String
    @Environment(\.colorScheme) var colorScheme
    var isSecure : Bool = false
    var placeholder : String
    var textColor : UIColor = .label
    var borderWidth : CGFloat = 1.0
    var cornerRadius : CGFloat = 8.0
    var backgroundColor : UIColor = .systemBackground
    
    func makeUIView(context: Context) -> UITextField {
        let textfield = UITextField()
        textfield.delegate = context.coordinator
        textfield.keyboardType = .default
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.placeholder = NSLocalizedString(placeholder, comment: "")
        textfield.font = .preferredFont(forTextStyle: .body)
        textfield.textColor = textColor
        textfield.layer.borderWidth = borderWidth
        textfield.borderRect(forBounds: CGRect(x: 0, y: 0, width: 10, height: 10))
        textfield.layer.cornerRadius = cornerRadius
        textfield.layer.borderWidth = borderWidth
        textfield.backgroundColor = backgroundColor
        borderColor(for: textfield, colorScheme: colorScheme)
        return textfield
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        uiView.isSecureTextEntry = isSecure
        uiView.layer.cornerRadius = cornerRadius
        uiView.layer.borderWidth = borderWidth
        uiView.backgroundColor = backgroundColor
        borderColor(for: uiView, colorScheme: colorScheme)
    }
    
    private func borderColor(for textfield: UITextField, colorScheme: ColorScheme) {
        let borderColor : UIColor = colorScheme == .dark ? .white : .black
        textfield.layer.borderColor = borderColor.cgColor
    }
    
    private func colorButton(for button: UIButton, colorScheme: ColorScheme) {
        let colorButton : UIColor = colorScheme == .dark ? .white : .black
        button.tintColor = colorButton
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, isSecure: isSecure, placeholder: placeholder)
    }
    
    final class Coordinator : NSObject, UITextFieldDelegate {
        @Binding var text : String
        var isSecure : Bool
        var placeholder : String
        
        init(text: Binding<String>, isSecure: Bool, placeholder: String) {
            self._text = text
            self.isSecure = isSecure
            self.placeholder = placeholder
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
            placeholder = textField.text ?? ""
        }
    }
}
