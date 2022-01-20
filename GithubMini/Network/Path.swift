//
//  Path.swift
//  GithubMini
//
//  Created by Sergio Ramos on 20.01.2022.
//

import Foundation

enum Path: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .user:
            return "user"
        case .repos:
            return "user/repos"
        }
    }
    
    case user
    case repos
}
