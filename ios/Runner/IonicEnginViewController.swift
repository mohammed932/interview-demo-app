//
//  IonicEnginViewController.swift
//  App
//
//  Created by laith bzour on 5/9/20.
//

import UIKit
import Foundation
import WebKit
import Cordova
import Capacitor

class IonicEnginViewController: CAPBridgeViewController {
    
    
    
    // MARK: - Init
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        NotificationCenter.default.removeObserver(self)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerEvent()
        self.view.backgroundColor = UIColor.white
    }
    
    
    func loadView(assetsFolder: String) {
        
        super.assetsFolder = assetsFolder
        super.loadView()
        super.view.backgroundColor = UIColor.white;
    }
    
    
    func registerEvent()  {
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("routeNotification"), object: nil)
    }
    
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        
        
    }
    
}


