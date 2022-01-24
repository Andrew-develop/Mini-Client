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
        guard let token = UserDefaults.standard.string(forKey: UserDefaultsKey.token) else { return }
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
    
    func setHandlers() {
        
        self.reposView?.onGetNumberOfReposHandler = { [weak self] in
            self?.interactor.numberOfRepos
        }
        
        self.reposView?.onGetRepoHandler = { [weak self] index in
            guard let crudeRepo = self?.interactor.getRepo(index: index) else { return nil }
            let repo = Repo.init(
                name: crudeRepo.name,
                date: self?.formatDate(from: crudeRepo.updated_at),
                stars: String(crudeRepo.stargazers_count),
                language: crudeRepo.language,
                originalRepo: crudeRepo.fork ? Constants.originalRepoLabelBase : nil
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
                self?.router.showAlert(title: AlertType.error, message: error.localizedDescription)
            }
        }
    }
    
    func formatDate(from stringDate: String) -> String? {
        guard let date = parseRecievedDate(stringDate: stringDate),
              let formattedDate = formatDate(from: date)
        else {
            return nil
        }
        return Constants.dateLabelBase + formattedDate
    }
    
    func parseRecievedDate(stringDate: String) -> Date? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = DateFormat.input
        return inputFormatter.date(from: stringDate)
    }
    
    func formatDate(from date: Date) -> String? {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = DateFormat.output
        return outputFormatter.string(from: date)
    }
}

private enum Constants {
    static let dateLabelBase = "Edited: "
    static let originalRepoLabelBase = "It's fork"
}

private enum DateFormat {
    static let input = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    static let output = "dd.MM.yyyy"
}
