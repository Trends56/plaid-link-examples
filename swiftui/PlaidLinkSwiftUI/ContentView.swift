//
//  ContentView.swift
//  PlaidLinkSwiftUI
//
//  Created by Will Kiefer on 11/25/19.
//  Copyright © 2019 Plaid. All rights reserved.
//

import SwiftUI
import LinkKit

struct ContentView: View {
    @State private var showLink = false
    
    var body: some View {
        Button(action: {
            self.showLink = true
        }) { Text("Add Account") }
            .sheet(isPresented: self.$showLink,
                onDismiss: {
                    self.showLink = false
                }, content: {
                    LinkView()
                })
    }
}

struct LinkView: View {
    var body: some View {
        LinkController()
    }
}


/// Controller object which providers interop between SwiftUI and traditional UIViewController delegate callbacks.
struct LinkController: UIViewControllerRepresentable {

    func makeCoordinator() -> LinkController.Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> PLKPlaidLinkViewController {
        let configuration = PLKConfiguration(key: "9a68f1bb1cbc223fff6a70adb33548", env: .sandbox, product: [.transactions])
        let vc = PLKPlaidLinkViewController(configuration: configuration, delegate: context.coordinator)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: PLKPlaidLinkViewController, context: Context) {
        
    }
    
    class Coordinator: NSObject, PLKPlaidLinkViewDelegate {
        var parent: LinkController
        
        init(_ parent: LinkController) {
            self.parent = parent
        }
        
        // MARK: PLKPlaidLinkViewDelegate
        
        func linkViewController(_ linkViewController: PLKPlaidLinkViewController, didSucceedWithPublicToken publicToken: String, metadata: [String : Any]?) {
            linkViewController.dismiss(animated: true, completion: nil)
            print("success!")
        }
        
        func linkViewController(_ linkViewController: PLKPlaidLinkViewController, didExitWithError error: Error?, metadata: [String : Any]?) {
            linkViewController.dismiss(animated: true, completion: nil)
            print("exit!")
        }
    }
}

