//
//  ReposAssembly.swift
//  GithubMini
//
//  Created by Sergio Ramos on 21.01.2022.
//

import Foundation

final class ReposAssembly {
    
    static func build() -> ReposViewController {
        let router = ReposRouter()
        let networkService = NetworkService()
        
        let interactor = ReposInteractor(
            dependencies: .init(
                networkService: networkService
            )
        )
        
        let presenter = ReposPresenter(
            dependencies: .init(
                interactor: interactor,
                router: router
            )
        )

        let controller = ReposViewController(
            dependencies: .init(presenter: presenter)
        )

        router.setRootController(controller: controller)
        
        return controller
    }
}
