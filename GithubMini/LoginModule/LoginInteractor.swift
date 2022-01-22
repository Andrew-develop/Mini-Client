//
//  LoginModel.swift
//  GithubMini
//
//  Created by Sergio Ramos on 20.01.2022.
//

import Foundation

protocol ILoginInteractor {
    func login(with requestData: RequestData)
    
    var onSuccessHandler: (() -> Void)? { get set }
    var onFailureHandler: ((Error) -> Void)? { get set }
}

final class LoginInteractor {
    
    private let networkService: INetworkService
    
    struct Dependencies {
        let networkService: INetworkService
    }

    init(dependencies: Dependencies) {
        self.networkService = dependencies.networkService
    }
    
    var onSuccessHandler: (() -> Void)?
    var onFailureHandler: ((Error) -> Void)?
}

extension LoginInteractor: ILoginInteractor {
    
    func login(with requestData: RequestData) {
        self.networkService.loadData(requestData: requestData) { [weak self] (result: Result<UserResponse, Error>) in
            switch result {
            case .success(_):
                UserDefaults.standard.setValue(requestData.token, forKey: UserDefaultsKey.token)
                self?.onSuccessHandler?()
            case .failure(let error):
                self?.onFailureHandler?(error)
            }
        }
    }
    
}
