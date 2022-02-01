//
//  LoginView.swift
//  GithubMini
//
//  Created by Sergio Ramos on 20.01.2022.
//

import UIKit
import SnapKit

protocol ILoginView: UIView {
    var onTouchedHandler: ((String?) -> Void)? { get set }
}

final class LoginView: UIView {
    
    var onTouchedHandler: ((String?) -> Void)?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.backgroundColor
        self.configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tokenTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = UITextField.placeholderText
        textField.borderStyle = .none
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(UIButton.buttonTitle, for: .normal)
        button.addTarget(self, action: #selector(onTouchedButton(sender:)), for: .touchUpInside)
        button.layer.cornerRadius = UIButton.cornerRadius
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 1
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        return recognizer
    }()
}

extension LoginView: ILoginView {}

private extension LoginView {
    
    @objc private func dismissKeyboard() {
        self.tokenTextField.resignFirstResponder()
    }
    
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
        self.tokenTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.left.equalTo(self).offset(Indent.edgeIndent)
            make.right.equalTo(self).inset(Indent.edgeIndent)
            make.height.equalTo(UITextField.standardHeight)
        }
    }
    
    func constraintLoginButton() {
        self.addSubview(self.loginButton)
        self.loginButton.snp.makeConstraints { make in
            make.top.equalTo(self.tokenTextField.snp.bottom).offset(Indent.standardHeightIndent)
            make.left.equalTo(self).offset(Indent.edgeIndent)
            make.right.equalTo(self).inset(Indent.edgeIndent)
            make.height.equalTo(UIButton.standardHeight)
        }
    }
}

extension LoginView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.addGestureRecognizer(self.tapRecognizer)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.removeGestureRecognizer(self.tapRecognizer)
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
