//
//  ReposRouter.swift
//  GithubMini
//
//  Created by Sergio Ramos on 21.01.2022.
//

import UIKit

final class ReposRouter {
    
    private weak var controller: UIViewController?
    
    func setRootController(controller: UIViewController) {
        self.controller = controller
    }
    
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .default, handler: nil))
        self.controller?.present(alert, animated: true, completion: nil)
    }
}
