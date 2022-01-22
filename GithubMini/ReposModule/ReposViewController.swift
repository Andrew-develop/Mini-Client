//
//  ReposViewController.swift
//  GithubMini
//
//  Created by Sergio Ramos on 21.01.2022.
//

import UIKit

final class ReposViewController: UIViewController {

    private var reposPresenter: IReposPresenter
    
    struct Dependencies {
        let presenter: IReposPresenter
    }
    
    init(dependencies: Dependencies) {
        self.reposPresenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let reposView = ReposView(frame: UIScreen.main.bounds)
        self.view = reposView
        self.reposPresenter.loadView(reposView: reposView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reposPresenter.onViewReady()
    }
}
