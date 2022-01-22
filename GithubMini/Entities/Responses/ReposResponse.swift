//
//  ReposResponse.swift
//  GithubMini
//
//  Created by Sergio Ramos on 21.01.2022.
//

import Foundation

struct RepoResponse: Decodable {
    let owner: Owner
    let name: String
    let fork: Bool
    let updated_at: String
    let stargazers_count: Int
    let language: String?
}

struct Owner: Codable {
    let login: String
}

