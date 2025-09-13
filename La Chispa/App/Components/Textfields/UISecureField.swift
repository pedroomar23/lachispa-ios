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
    var isSecure : Bool = false
    var placeholder : String
    var textColor : UIColor = .clear
    var borderWidth : CGFloat = 0
    
    func makeUIView(context: Context) -> UITextField {
        let textfield = UITextField()
        textfield.delegate = context.coordinator
        textfield.keyboardType = .emailAddress
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .default
        textfield.placeholder = NSLocalizedString(placeholder, comment: "")
        textfield.font = .preferredFont(forTextStyle: .body)
        textfield.textColor = textColor
        textfield.layer.borderWidth = borderWidth
        textfield.borderRect(forBounds: CGRect(x: 0, y: 0, width: 5, height: 5))
        return textfield
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        uiView.isSecureTextEntry = isSecure
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
