//
//  InvoiceTextField.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/28/25.
//

import UIKit
import SwiftUI

struct InvoiceTextfield : UIViewRepresentable {
    typealias UIViewType = UITextField
    
    @Environment(\.colorScheme) var colorScheme
    @Binding var text : String
    var placeholder: String
    var isSecure : Bool = false
    var backgroundColor : UIColor = .systemBackground
    var textColor : UIColor = .label
    var maxWidth: CGFloat? = nil
    var cornerRadius : CGFloat = 8.0
    var borderWidth : CGFloat = 1.5
    
    func makeUIView(context: Context) -> UITextField {
        let textfield = UITextField()
        textfield.keyboardType = .numberPad
        textfield.placeholder = NSLocalizedString(placeholder, comment: "")
        textfield.borderStyle = .roundedRect
        textfield.layer.borderWidth = borderWidth
        textfield.layer.cornerRadius = cornerRadius
        textfield.textColor = textColor
        textfield.backgroundColor = backgroundColor
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .default
        textfield.font = .preferredFont(forTextStyle: .body)
        textfield.textAlignment = .left
        textfield.borderRect(forBounds: CGRect(x: 0, y: 0, width: 10, height: 10))
        textfield.delegate = context.coordinator
        color(textfield: textfield, colorScheme: colorScheme)
        return textfield
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        uiView.delegate = context.coordinator
        uiView.placeholder = placeholder
        uiView.layer.borderWidth = borderWidth
        uiView.layer.cornerRadius = cornerRadius
        uiView.textColor = textColor
        uiView.isSecureTextEntry = isSecure
        uiView.backgroundColor = backgroundColor
        uiView.textColor = textColor
        uiView.minimumFontSize = 10
        uiView.setNeedsLayout()
        uiView.addTarget(context.coordinator, action: #selector(Coordinator.textChagend(_:)), for: .editingChanged)
        color(textfield: uiView, colorScheme: colorScheme)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(placeholder: placeholder, text: $text , isSecure: isSecure)
    }
    
    final class Coordinator : NSObject, UITextFieldDelegate {
        @Binding var text : String
        var placeholder : String
        var isSecure : Bool
        
        init(placeholder: String, text: Binding<String> ,isSecure: Bool) {
            self.placeholder = placeholder
            self._text = text
            self.isSecure = isSecure
        }
        
        @objc func textChagend(_ textfield: UITextField) {
            text = textfield.text ?? ""
        }
        
        @objc func doneButtonTapped() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    private func color(textfield: UITextField, colorScheme: ColorScheme) {
        let color : UIColor = colorScheme == .dark ? .blue : .blue
        textfield.textColor = color
        
        let borderColor : UIColor = colorScheme == .dark ? .white : .blue
        textfield.layer.borderColor = borderColor.cgColor
    }
}
