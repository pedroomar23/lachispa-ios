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
    
    @Binding var amount : Int
    @Environment(\.colorScheme) var colorScheme
    var text : String
    var isSecure : Bool = false
    var backgroundColor : UIColor = .systemGroupedBackground
    var textColor : UIColor = .label
    
    func makeUIView(context: Context) -> UITextField {
        let textfield = UITextField()
        textfield.keyboardType = .numberPad
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .default
        textfield.font = .preferredFont(forTextStyle: .body)
        textfield.borderRect(forBounds: CGRect(x: 0, y: 0, width: 10, height: 10))
        textfield.delegate = context.coordinator
        color(textfield: textfield, colorScheme: colorScheme)
        updateBalance(textfield, amount: amount)
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: context.coordinator, action: #selector(Coordinator.doneButtonTapped))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexSpace, doneButton]
        textfield.inputAccessoryView = toolbar
        return textfield
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.delegate = context.coordinator
        uiView.isSecureTextEntry = isSecure
        uiView.backgroundColor = backgroundColor
        uiView.textColor = textColor
        color(textfield: uiView, colorScheme: colorScheme)
        
        if !uiView.isFirstResponder {
            updateBalance(uiView, amount: amount)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(amount: $amount, text: text ,isSecure: isSecure)
    }
    
    final class Coordinator : NSObject, UITextFieldDelegate {
        @Binding var amount : Int
        var text : String
        var isSecure : Bool
        
        init(amount: Binding<Int>, text: String, isSecure: Bool) {
            self._amount = amount
            self.text = text
            self.isSecure = isSecure
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            if let text = textField.text, !text.isEmpty {
                textField.text = "\(amount) sats"
            }
        }
        
        @objc func doneButtonTapped() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    private func updateBalance(_ textfield: UITextField, amount: Int) {
        if amount == 0 {
            textfield.text = ""
        } else {
            textfield.text = "\(amount) sats"
        }
    }
    
    private func color(textfield: UITextField, colorScheme: ColorScheme) {
        let color : UIColor = colorScheme == .dark ? .blue : .blue
        textfield.textColor = color
    }
}
