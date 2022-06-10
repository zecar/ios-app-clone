//
//  CallController.swift
//  LClone
//
//  Created by Ionut Capraru on 09.06.2022.
//

import Foundation
import SwiftUI
import WebKit

class CallViewController: UIViewController {
//    this view normally expands when there is a call active. removed the code because is not relevant for the example but kept the file because of the view constraints
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
    }
}

struct CallView: View {
    typealias UIViewControllerType = UIViewController
    
    var body: some View {
        Section {
            Text("asd")
        }
    }
    
    
    struct CallViewRepresentable: UIViewControllerRepresentable {
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<CallView.CallViewRepresentable>) -> UIViewController {

            return CallViewController()
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<CallView.CallViewRepresentable>) {
        }
    }
}
