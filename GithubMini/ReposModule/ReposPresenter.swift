//
//  ReposPresenter.swift
//  GithubMini
//
//  Created by Sergio Ramos on 21.01.2022.
//

import Foundation

protocol IReposPresenter: AnyObject {
    func loadView(reposView: IReposView)
    func onViewReady()
}

final class ReposPresenter {
    
    private weak var reposView: IReposView?
    private var interactor: IReposInteractor
    private let router: ReposRouter
    
    struct Dependencies {
        let interactor: IReposInteractor
        let router: ReposRouter
    }
    
    init(dependencies: Dependencies) {
        self.interactor = dependencies.interactor
        self.router = dependencies.router
    }
}

extension ReposPresenter: IReposPresenter {
    
    func loadView(reposView: IReposView) {
        self.reposView = reposView
        self.setHandlers()
    }
    
    func onViewReady() {
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        self.interactor.fetchRepos(
            with: .init(
                path: .repos,
                token: token
            )
        )
        self.reposView?.startIndicator()
    }
}

private extension ReposPresenter {
    
    private func setHandlers() {
        
        self.reposView?.onGetNumberOfReposHandler = { [weak self] in
            self?.interactor.numberOfRepos
        }
        
        self.reposView?.onGetRepoHandler = { [weak self] index in
            guard let crudeRepo = self?.interactor.getRepo(index: index) else { return nil }
            let repo = Repo.init(
                name: crudeRepo.name,
                date: crudeRepo.updated_at,
                stars: String(crudeRepo.stargazers_count),
                language: crudeRepo.language,
                originalRepo: nil
            )
            return repo
        }
        
        self.interactor.onSuccessHandler = { [weak self] in
            DispatchQueue.main.async {
                self?.reposView?.stopIndicator()
                self?.reposView?.update()
            }
        }
        
        self.interactor.onFailureHandler = { [weak self] error in
            DispatchQueue.main.async {
                self?.reposView?.stopIndicator()
                self?.router.showAlert(title: "Ошибка", message: error.localizedDescription)
            }
        }
    }
}
