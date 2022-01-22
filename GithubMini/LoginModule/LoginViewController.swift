//
//  ViewController.swift
//  GithubMini
//
//  Created by Sergio Ramos on 20.01.2022.
//

import UIKit

final class LoginViewController: UIViewController {

    private var loginPresenter: ILoginPresenter
    
    struct Dependencies {
        let presenter: ILoginPresenter
    }

    init(dependencies: Dependencies) {
        self.loginPresenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let loginView = LoginView(frame: UIScreen.main.bounds)
        self.view = loginView
        self.loginPresenter.loadView(loginView: loginView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

