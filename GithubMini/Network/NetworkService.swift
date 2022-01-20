//
//  NetworkService.swift
//  GithubMini
//
//  Created by Sergio Ramos on 20.01.2022.
//

import Foundation

protocol INetworkService {
    func loadData<T: Decodable>(requestData: RequestData, completion: @escaping (Result<T, Error>) -> Void)
}

final class NetworkService {
    
    private let session: URLSession
    private let basePath = "https://api.github.com/"

    init(configuration: URLSessionConfiguration? = nil) {
        if let configuration = configuration {
            self.session = URLSession(configuration: configuration)
        }
        else {
            self.session = URLSession(configuration: URLSessionConfiguration.default)
        }
    }
}

extension NetworkService: INetworkService {
    
    func loadData<T: Decodable>(requestData: RequestData, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = self.makeURL(from: requestData.path) else { return }
        
        let request = makeURLRequest(url: url, token: requestData.token)
        self.session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

private extension NetworkService {
    
    func makeURL(from path: Path) -> URL? {
        URL(string: self.basePath + path.description)
    }
    
    func makeURLRequest(url: URL, token: String) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}
