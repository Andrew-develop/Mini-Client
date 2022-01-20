//
//  LoginView.swift
//  GithubMini
//
//  Created by Sergio Ramos on 20.01.2022.
//

import UIKit

protocol ILoginView: UIView {
    var onTouchedHandler: ((String?) -> Void)? { get set }
}

final class LoginView: UIView {
    
    var onTouchedHandler: ((String?) -> Void)?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tokenTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = UITextField.placeholderText
        textField.borderStyle = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(UIButton.buttonTitle, for: .normal)
        button.addTarget(self, action: #selector(onTouchedButton(sender:)), for: .touchUpInside)
        button.layer.cornerRadius = UIButton.cornerRadius
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}

extension LoginView: ILoginView {}

private extension LoginView {
    
    @objc func onTouchedButton(sender: UIButton) {
        let token = self.tokenTextField.text
        self.onTouchedHandler?(token)
    }
    
    func configView() {
        self.constraintTokenTextField()
        self.constraintLoginButton()
    }
    
    func constraintTokenTextField() {
        self.addSubview(self.tokenTextField)
        NSLayoutConstraint.activate([
            self.tokenTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Indent.edgeIndent),
            self.tokenTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Indent.edgeIndent),
            self.tokenTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.tokenTextField.heightAnchor.constraint(equalToConstant: UITextField.standardHeight)
        ])
    }
    
    func constraintLoginButton() {
        self.addSubview(self.loginButton)
        NSLayoutConstraint.activate([
            self.loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Indent.edgeIndent),
            self.loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Indent.edgeIndent),
            self.loginButton.topAnchor.constraint(equalTo: self.tokenTextField.bottomAnchor, constant: Indent.standardHeightIndent),
            self.loginButton.heightAnchor.constraint(equalToConstant: UIButton.standardHeight)
        ])
    }
}

private enum Indent {
    static let edgeIndent: CGFloat = 20
    static let standardHeightIndent: CGFloat = 20
}

private extension UITextField {
    static let standardHeight: CGFloat = 44
    static let placeholderText = "Введите ваш токен"
}

private extension UIButton {
    static let standardHeight: CGFloat = 44
    static let buttonTitle = "Войти"
    static let cornerRadius: CGFloat = 10
}
