//
//  ReposInteractor.swift
//  GithubMini
//
//  Created by Sergio Ramos on 21.01.2022.
//

import Foundation

protocol IReposInteractor {
    func fetchRepos(with requestData: RequestData)
    func getRepo(index: Int) -> RepoResponse
    
    var numberOfRepos: Int { get }
    var onSuccessHandler: (() -> Void)? { get set }
    var onFailureHandler: ((Error) -> Void)? { get set }
}

final class ReposInteractor {
    
    private let networkService: INetworkService
    
    struct Dependencies {
        let networkService: INetworkService
    }
    
    init(dependencies: Dependencies) {
        self.networkService = dependencies.networkService
    }
    
    var onSuccessHandler: (() -> Void)?
    var onFailureHandler: ((Error) -> Void)?
    
    private var repos: [RepoResponse] = []
    
    var numberOfRepos: Int {
        self.repos.count
    }
}

extension ReposInteractor: IReposInteractor {
    
    func fetchRepos(with requestData: RequestData) {
        self.networkService.loadData(requestData: requestData) { [weak self] (result: Result<[RepoResponse], Error>) in
            switch result {
            case .success(let success):
                self?.repos = success
                self?.onSuccessHandler?()
            case .failure(let failure):
                self?.onFailureHandler?(failure)
            }
        }
    }
    
    func getRepo(index: Int) -> RepoResponse {
        self.repos[index]
    }
}
