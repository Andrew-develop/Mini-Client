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
        dateLabel.textAlignment = .right
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
        starImageView.image = UIImage.starImage
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
        self.backgroundColor = UIColor.backgroundColor
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
        self.starLabel.text = nil
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
            self.nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Indent.edgeIndent),
            self.nameLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: Multiplier.nameLabelMultiplier),
            self.nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: self.contentView.bounds.height * Multiplier.heightIndentMultiplier),
            self.nameLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: Multiplier.heightMultiplier)
        ])
    }
    
    func constraintStarImageView() {
        self.contentView.addSubview(self.starImageView)
        NSLayoutConstraint.activate([
            self.starImageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: Multiplier.heightMultiplier),
            self.starImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Indent.edgeIndent),
            self.starImageView.widthAnchor.constraint(equalTo: self.starImageView.heightAnchor),
            self.starImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: self.contentView.bounds.height * Multiplier.heightIndentMultiplier)
        ])
    }
    
    func constraintStarLabel() {
        self.contentView.addSubview(self.starLabel)
        NSLayoutConstraint.activate([
            self.starLabel.trailingAnchor.constraint(equalTo: self.starImageView.leadingAnchor, constant: -Indent.edgeIndent),
            self.starLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: Multiplier.starLabelMultiplier),
            self.starLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: self.contentView.bounds.height * Multiplier.heightIndentMultiplier),
            self.starLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: Multiplier.heightMultiplier)
        ])
    }
    
    func constraintOriginalRepo() {
        self.contentView.addSubview(self.originalRepoLabel)
        NSLayoutConstraint.activate([
            self.originalRepoLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Indent.edgeIndent),
            self.originalRepoLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Indent.edgeIndent),
            self.originalRepoLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: self.contentView.bounds.height * Multiplier.heightIndentMultiplier),
            self.originalRepoLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: Multiplier.heightMultiplier)
        ])
    }
    
    func constraintLanguageLabel() {
        self.contentView.addSubview(self.languageLabel)
        NSLayoutConstraint.activate([
            self.languageLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Indent.edgeIndent),
            self.languageLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: Multiplier.languageLabelMultiplier),
            self.languageLabel.topAnchor.constraint(equalTo: self.originalRepoLabel.bottomAnchor, constant: self.contentView.bounds.height * Multiplier.heightIndentMultiplier),
            self.languageLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: Multiplier.heightMultiplier)
        ])
    }
    
    func constraintDateLabel() {
        self.contentView.addSubview(self.dateLabel)
        NSLayoutConstraint.activate([
            self.dateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Indent.edgeIndent),
            self.dateLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: Multiplier.dateLabelMultiplier),
            self.dateLabel.topAnchor.constraint(equalTo: self.originalRepoLabel.bottomAnchor, constant: self.contentView.bounds.height * Multiplier.heightIndentMultiplier),
            self.dateLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: Multiplier.heightMultiplier)
        ])
    }
}

private extension UIImage {
    static let starImage = UIImage(named: "star")
}

private enum Indent {
    static let edgeIndent: CGFloat = 8
}

private enum Multiplier {
    static let heightMultiplier: CGFloat = 0.28
    static let heightIndentMultiplier: CGFloat = 0.08
    static let starLabelMultiplier: CGFloat = 0.2
    static let nameLabelMultiplier: CGFloat = 0.6
    static let languageLabelMultiplier: CGFloat = 0.45
    static let dateLabelMultiplier: CGFloat = 0.45
}


