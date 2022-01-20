//
//  LoginAssembly.swift
//  GithubMini
//
//  Created by Sergio Ramos on 20.01.2022.
//

import Foundation

final class LoginAssembly {
    
    static func build() -> LoginViewController {
        let router = LoginRouter()
        let networkService = NetworkService()
        
        let interactor = LoginInteractor(
            dependencies: .init(
                networkService: networkService
            )
        )
        
        let presenter = LoginPresenter(
            dependencies: .init(
                interactor: interactor,
                router: router
            )
        )

        let controller = LoginViewController(
            dependencies: .init(presenter: presenter)
        )

        router.setRootController(controller: controller)
        
        return controller
    }
}
