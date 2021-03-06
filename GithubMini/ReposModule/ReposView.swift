//
//  ReposView.swift
//  GithubMini
//
//  Created by Sergio Ramos on 21.01.2022.
//

import UIKit
import SnapKit

protocol IReposView: UIView {
    func startIndicator()
    func stopIndicator()
    func update()
    
    var onGetNumberOfReposHandler: (() -> Int?)? { get set }
    var onGetRepoHandler: ((Int) -> Repo?)? { get set }
}

final class ReposView: UIView {
    
    var onGetNumberOfReposHandler: (() -> Int?)?
    var onGetRepoHandler: ((Int) -> Repo?)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.backgroundColor
        self.configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ReposTableViewCell.self, forCellReuseIdentifier: ReposTableViewCell.cellID)
        tableView.backgroundColor = UIColor.backgroundColor
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.allowsSelection = false
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
}

extension ReposView: IReposView {
    
    func startIndicator() {
        self.activityIndicator.startAnimating()
    }
    
    func stopIndicator() {
        self.activityIndicator.stopAnimating()
    }
    
    func update() {
        self.tableView.reloadData()
    }
}

private extension ReposView {
    
    func configView() {
        self.constraintTableView()
        self.constraintActivityIndicator()
    }
    
    func constraintTableView() {
        self.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.safeAreaLayoutGuide)
            make.left.equalTo(self).offset(Indent.edgeIndent)
            make.right.equalTo(self).inset(Indent.edgeIndent)
        }
    }
    
    func constraintActivityIndicator() {
        self.addSubview(self.activityIndicator)
        self.activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
        }
    }
}

extension ReposView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.cellHeight
    }
}

extension ReposView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let a = self.onGetNumberOfReposHandler?() ?? 0
        return a
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReposTableViewCell.cellID) as? ReposTableViewCell
        else {
            return UITableViewCell()
        }
        
        if let repo = self.onGetRepoHandler?(indexPath.row) {
            cell.config(repo: repo)
        }
        
        return cell
    }
}

private enum Indent {
    static let edgeIndent: CGFloat = 20
}

private extension UITableView {
    static let cellHeight: CGFloat = 72
}
