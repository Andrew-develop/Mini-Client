//
//  ReposView.swift
//  GithubMini
//
//  Created by Sergio Ramos on 21.01.2022.
//

import UIKit

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
        self.backgroundColor = UIColor.white
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
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
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
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Indent.edgeIndent),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Indent.edgeIndent),
            self.tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func constraintActivityIndicator() {
        self.addSubview(self.activityIndicator)
        NSLayoutConstraint.activate([
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

extension ReposView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

extension ReposView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.onGetNumberOfReposHandler?() ?? 0
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
