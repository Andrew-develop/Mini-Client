//
//  ReposTableViewCell.swift
//  GithubMini
//
//  Created by Sergio Ramos on 21.01.2022.
//

import UIKit
import SnapKit

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
        starLabel.backgroundColor = .green
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
        languageLabel.textAlignment = .left
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        return languageLabel
    }()
    
    private lazy var originalRepoLabel: UILabel = {
        let originalRepoLabel = UILabel()
        originalRepoLabel.textAlignment = .left
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
        self.fillView(repo: repo)
    }
}

private extension ReposTableViewCell {
    
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
        self.nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.left.equalTo(self).offset(Indent.edgeIndent)
            make.height.equalTo(self).multipliedBy(0.33)
        }
    }
    
    func constraintStarImageView() {
        self.contentView.addSubview(self.starImageView)
        self.starImageView.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.right.equalTo(self).inset(Indent.edgeIndent)
            make.width.height.equalTo(16)
        }
    }
    
    func constraintStarLabel() {
        self.contentView.addSubview(self.starLabel)
        self.starLabel.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.left.equalTo(self.nameLabel.snp.right)
            make.right.equalTo(self.starImageView.snp.left)
            make.height.equalTo(self).multipliedBy(0.33)
        }
    }
    
    func constraintOriginalRepo() {
        self.contentView.addSubview(self.originalRepoLabel)
        self.originalRepoLabel.snp.makeConstraints { make in
            make.top.equalTo(self.nameLabel.snp.bottom)
            make.left.equalTo(self).offset(Indent.edgeIndent)
            make.right.equalTo(self).inset(Indent.edgeIndent)
            make.height.equalTo(self).multipliedBy(0.33)
        }
    }
    
    func constraintLanguageLabel() {
        self.contentView.addSubview(self.languageLabel)
        self.languageLabel.snp.makeConstraints { make in
            make.top.equalTo(self.originalRepoLabel.snp.bottom)
            make.left.equalTo(self).offset(Indent.edgeIndent)
            make.height.equalTo(self).multipliedBy(0.33)
        }
    }
    
    func constraintDateLabel() {
        self.contentView.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.originalRepoLabel.snp.bottom)
            make.right.equalTo(self).inset(Indent.edgeIndent)
            make.bottom.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.33)
        }
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


