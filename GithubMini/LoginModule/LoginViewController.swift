//
//  ViewController.swift
//  GithubMini
//
//  Created by Sergio Ramos on 20.01.2022.
//

import UIKit

final class LoginViewController: UIViewController {

    private var loginPresenter: ILoginPresenter
    private var loginView: ILoginView
    
    struct Dependencies {
        let presenter: ILoginPresenter
    }

    init(dependencies: Dependencies) {
        self.loginView = LoginView(frame: UIScreen.main.bounds)
        self.loginPresenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.loginView
        self.loginPresenter.loadView(loginView: self.loginView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

