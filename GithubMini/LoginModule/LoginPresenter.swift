//
//  LoginPresenter.swift
//  GithubMini
//
//  Created by Sergio Ramos on 20.01.2022.
//

import Foundation

protocol ILoginPresenter {
    func loadView(loginView: ILoginView)
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
    
    func loadView(loginView: ILoginView) {
        self.loginView = loginView
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
            DispatchQueue.main.async {
                self?.loginRouter.setTargetController()
                self?.loginRouter.next()
            }
        }
        
        self.loginInteractor.onFailureHandler = { [weak self] error in
            DispatchQueue.main.async {
                self?.loginRouter.showAlert(title: AlertType.error, message: error.localizedDescription)
            }
        }
    }
}
