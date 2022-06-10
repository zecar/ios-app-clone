//
//  AppViewController.swift
//  LClone
//
//  Created by Ionut Capraru on 09.06.2022.
//

import Foundation
import SwiftUI
import WebKit
import Network

class AppViewController: UIViewController, UINavigationControllerDelegate {
    var webViewController: WebViewController!
    var callViewController: CallViewController!
    var videoHeightClosedConstraint: NSLayoutConstraint!
    var kbSize: Double = 0.0
    var originalFrame: CGRect!
    var keyboardOpenedFrame: CGRect!
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    @objc func keyboardDidShow(notification: NSNotification){
        print("[LOG] DID SHOW")
        
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                kbSize = keyboardSize.height
                print("[LOG] GOT HEIGHT \(kbSize)")
            }
        }
        self.keyboardOpenedFrame = CGRect(x: 0, y: 0.5, width: self.view.frame.width, height: self.originalFrame.height - kbSize)
        
        print("[LOG] SETTING FRAME \(self.keyboardOpenedFrame)")
        self.view.frame = self.keyboardOpenedFrame

    }
    
    @objc func keyboardDidHide(notification: NSNotification){
        print("[LOG] DID HIDE")
        print("[LOG] SETTING FRAME \(self.originalFrame)")
        self.view.frame = self.originalFrame
    }
    
    @objc func setLayout(){
        if #available(iOS 11.0, *) {
            let window = UIWindow.key
            self.originalFrame = CGRect(x: 0, y: 0.5, width: self.view.frame.width, height: self.view.frame.height)
            self.view.frame = originalFrame
        }
        
        self.callViewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.callViewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.callViewController.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        
        self.videoHeightClosedConstraint = self.callViewController.view.heightAnchor.constraint(equalToConstant: 0)
        self.videoHeightClosedConstraint.isActive = true
        self.callViewController.view.alpha = 0
        
        self.webViewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.webViewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.webViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.webViewController.view.topAnchor.constraint(equalTo: self.callViewController.view.bottomAnchor).isActive = true
        self.webViewController.view.layer.borderWidth = 5
        self.webViewController.view.layer.borderColor = UIColor.green.cgColor
        self.webViewController.view.backgroundColor = UIColor.blue
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.webViewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.callViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.setLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("[LOG] SETTING OBSERVERS")
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        self.view.insetsLayoutMarginsFromSafeArea = false
        
        self.webViewController = WebViewController()
        self.callViewController = CallViewController()
        
        self.addChild(self.webViewController)
        self.addChild(self.callViewController)
        
        self.view.addSubview(self.webViewController.view)
        self.view.addSubview(self.callViewController.view)
    }
}

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
