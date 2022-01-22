//
//  ReposTableViewCell.swift
//  GithubMini
//
//  Created by Sergio Ramos on 21.01.2022.
//

import UIKit

protocol IReposTableViewCell {
    func config(repo: Repo)
}

final class ReposTableViewCell: UITableViewCell {
    
    static let cellID = String(describing: self)
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    private lazy var starLabel: UILabel = {
        let starLabel = UILabel()
        starLabel.textAlignment = .right
        starLabel.translatesAutoresizingMaskIntoConstraints = false
        return starLabel
    }()
    
    private lazy var starImageView: UIImageView = {
        let starImageView = UIImageView()
        starImageView.image = UIImage(named: "star")
        starImageView.contentMode = .scaleAspectFit
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        return starImageView
    }()
    
    private lazy var languageLabel: UILabel = {
        let languageLabel = UILabel()
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        return languageLabel
    }()
    
    private lazy var originalRepoLabel: UILabel = {
        let originalRepoLabel = UILabel()
        originalRepoLabel.translatesAutoresizingMaskIntoConstraints = false
        return originalRepoLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ReposTableViewCell: IReposTableViewCell {
    
    func config(repo: Repo) {
        self.clearCell()
        self.fillView(repo: repo)
    }
}

private extension ReposTableViewCell {
    
    func clearCell() {
        self.nameLabel.text = nil
        self.dateLabel.text = nil
        self.languageLabel.text = nil
        self.originalRepoLabel.text = nil
    }
    
    func fillView(repo: Repo) {
        self.nameLabel.text = repo.name
        self.dateLabel.text = repo.date
        self.languageLabel.text = repo.language
        self.originalRepoLabel.text = repo.originalRepo
        self.starLabel.text = repo.stars
    }
    
    func setupConstraints() {
        self.constraintNameLabel()
        self.constraintStarImageView()
        self.constraintStarLabel()
        self.constraintOriginalRepo()
        self.constraintLanguageLabel()
        self.constraintDateLabel()
    }
    
    func constraintNameLabel() {
        self.contentView.addSubview(self.nameLabel)
        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            self.nameLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.6),
            self.nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: self.contentView.bounds.height * 0.08),
            self.nameLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.28)
        ])
    }
    
    func constraintStarImageView() {
        self.contentView.addSubview(self.starImageView)
        NSLayoutConstraint.activate([
            self.starImageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.28),
            self.starImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            self.starImageView.widthAnchor.constraint(equalTo: self.starImageView.heightAnchor),
            self.starImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: self.contentView.bounds.height * 0.08)
        ])
    }
    
    func constraintStarLabel() {
        self.contentView.addSubview(self.starLabel)
        NSLayoutConstraint.activate([
            self.starLabel.trailingAnchor.constraint(equalTo: self.starImageView.leadingAnchor, constant: -8),
            self.starLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.2),
            self.starLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: self.contentView.bounds.height * 0.08),
            self.starLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.28)
        ])
    }
    
    func constraintOriginalRepo() {
        self.contentView.addSubview(self.originalRepoLabel)
        NSLayoutConstraint.activate([
            self.originalRepoLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            self.originalRepoLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            self.originalRepoLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: self.contentView.bounds.height * 0.08),
            self.originalRepoLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.28)
        ])
    }
    
    func constraintLanguageLabel() {
        self.contentView.addSubview(self.languageLabel)
        NSLayoutConstraint.activate([
            self.languageLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            self.languageLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.4),
            self.languageLabel.topAnchor.constraint(equalTo: self.originalRepoLabel.bottomAnchor, constant: self.contentView.bounds.height * 0.08),
            self.languageLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.28)
        ])
    }
    
    func constraintDateLabel() {
        self.contentView.addSubview(self.dateLabel)
        NSLayoutConstraint.activate([
            self.dateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            self.dateLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.4),
            self.dateLabel.topAnchor.constraint(equalTo: self.originalRepoLabel.bottomAnchor, constant: self.contentView.bounds.height * 0.08),
            self.dateLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.28)
        ])
    }
}
