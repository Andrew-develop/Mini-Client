//
//  LoginRouter.swift
//  GithubMini
//
//  Created by Sergio Ramos on 20.01.2022.
//

import UIKit

final class LoginRouter {
    
    private var controller: UIViewController?
    private var targetController: UIViewController?
    
    func setRootController(controller: UIViewController) {
        self.controller = controller
    }
    
    func setTargetController() {
//        self.targetController = ReposListAssembly.build()
    }
    
    func next() {
        guard let targetController = self.targetController else {
            return
        }
        
        self.controller?.navigationController?.pushViewController(targetController, animated: true)
    }
}
