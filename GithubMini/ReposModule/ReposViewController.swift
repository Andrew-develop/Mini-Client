//
//  ReposViewController.swift
//  GithubMini
//
//  Created by Sergio Ramos on 21.01.2022.
//

import UIKit

final class ReposViewController: UIViewController {

    private var reposPresenter: IReposPresenter
    private var reposView: IReposView
    
    struct Dependencies {
        let presenter: IReposPresenter
    }
    
    init(dependencies: Dependencies) {
        self.reposView = ReposView(frame: UIScreen.main.bounds)
        self.reposPresenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.reposView
        self.reposPresenter.loadView(reposView: self.reposView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reposPresenter.onViewReady()
    }
}
