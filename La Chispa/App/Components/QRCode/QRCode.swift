//
//  QRCode.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import UIKit
import SwiftUI
import AVFoundation

struct QRCodeScannerController: UIViewControllerRepresentable {
    @Binding var scannedCode: String
    @Binding var errorMessage: String
    var amount: Int
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let scannerViewController = ScannerViewController()
        scannerViewController.delegate = context.coordinator
        
        let navigationController = UINavigationController(rootViewController: scannerViewController)
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, ScannerDelegate {
        var parent: QRCodeScannerController
        
        init(_ parent: QRCodeScannerController) {
            self.parent = parent
        }
        
        func didFindCode(_ code: String) {
            parent.scannedCode = code
        }
        
        func didFindAmount(_ amount: Int) {
            parent.amount = amount
        }
        
        func didFailWithError(_ error: String) {
            parent.errorMessage = error
        }
    }
}

protocol ScannerDelegate: AnyObject {
    func didFindCode(_ code: String)
    func didFindAmount(_ amount: Int)
    func didFailWithError(_ error: String)
}







