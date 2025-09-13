//
//  Safari.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import UIKit
import SwiftUI
import SafariServices

struct SafariWebView : UIViewControllerRepresentable {
    let url : URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) { }
}

struct WebViewSheet : View {
    let url : URL
    
    var body : some View {
        ContentNavigation {
            SafariWebView(url: url)
        }
    }
}
