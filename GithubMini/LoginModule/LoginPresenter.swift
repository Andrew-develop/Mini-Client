//
//  LoginPresenter.swift
//  GithubMini
//
//  Created by Sergio Ramos on 20.01.2022.
//

import Foundation

protocol ILoginPresenter {
    func loadView(view: ILoginView)
}

final class LoginPresenter {
    
    private var loginInteractor: ILoginInteractor
    private weak var loginView: ILoginView?
    private let loginRouter: LoginRouter
    
    struct Dependencies {
        let interactor: ILoginInteractor
        let router: LoginRouter
    }

    init(dependencies: Dependencies) {
        self.loginInteractor = dependencies.interactor
        self.loginRouter = dependencies.router
    }
}

extension LoginPresenter: ILoginPresenter {
    
    func loadView(view: ILoginView) {
        self.setHandlers()
    }
}

private extension LoginPresenter {
    
    func setHandlers() {
            
        self.loginView?.onTouchedHandler = { [weak self] token in
            guard let token = token else { return }
            let requestData = RequestData(path: .user, token: token)
            self?.loginInteractor.login(with: requestData)
        }
        
        self.loginInteractor.onSuccessHandler = { [weak self] in
            self?.loginRouter.setTargetController()
            self?.loginRouter.next()
        }
        
        self.loginInteractor.onFailureHandler = { [weak self] error in
//            self?.loginRouter
        }
    }
}
