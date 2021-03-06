//
//  LoginRouter.swift
//  GithubMini
//
//  Created by Sergio Ramos on 20.01.2022.
//

import UIKit

final class LoginRouter {
    
    private weak var controller: UIViewController?
    private var targetController: UIViewController?
    
    func setRootController(controller: UIViewController) {
        self.controller = controller
    }
    
    func setTargetController() {
        self.targetController = ReposAssembly.build()
    }
    
    func next() {
        guard let targetController = self.targetController else {
            return
        }
        
        self.controller?.navigationController?.pushViewController(targetController, animated: true)
    }
    
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .default, handler: nil))
        self.controller?.present(alert, animated: true, completion: nil)
    }
}
