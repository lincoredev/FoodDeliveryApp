//
//  LoginViewController.swift
//  FoodDeliveryApp
//
//  Created by Vova Lincore on 04.04.2024.
//

import UIKit

enum LoginViewState {
    case initial
    case signIn
    case signUp
}

protocol LoginViewInput: AnyObject {
    func onSignInTapped()
    func onSignUpTapped()
    func onFacebookTapped()
    func onGoogleTapped()
    func onForgotTapped()
    func onBackPressed()
}

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    private var state: LoginViewState = .initial
    var viewOutput: LoginViewOutput!
    
    // MARK: - Views
    private lazy var bottomView = FDBottomView()
    private lazy var titleLabel = UILabel()
    private lazy var signInUsernameTF = FDTextField()
    private lazy var signInPasswordTF = FDTextField()
    private lazy var signUpUsernameTF = FDTextField()
    private lazy var signUpPasswordTF = FDTextField()
    private lazy var signUpReEnterPasswordTF = FDTextField()
    private lazy var forgotLabel = UILabel()
    private lazy var logoImageView = UIImageView()
    private lazy var signInButton = FDButton()
    private lazy var signUpButton = FDButton()
    private lazy var verticalStack = UIStackView()
    
    // MARK: - Inits
    init(viewOutput: LoginViewOutput, state: LoginViewState) {
        self.viewOutput = viewOutput
        self.state = state
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }

    func facebookPress() {
        print("facebook ")
    }
    
    func googlePress() {
        print("google ")
    }
}

// MARK: - Layout
private extension LoginViewController {
    func setupLayout() {
        switch state {
        case .initial:
            setupBottomView()
            setupLogoImageView()
            setupSignInButton()
            setupSignUpButton()
        case .signIn:
            setupBottomView()
            setupStack()
            setupSignInPasswordTF()
            setupSignInUsernameTF()
            setupTitleLabel()
            setupSignInButton()
            setupForgotLabel() 
        case .signUp:
            setupBottomView()
            setupStack()
            setupSignUpPasswordTF()
            setupSignUpUsernameTF()
            setupSignUpReEnterPasswordTF()
            setupTitleLabel()
            setupSignInButton()
            setupForgotLabel()
        }
    }
    func setupStack() {
        view.addSubview(verticalStack)
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.axis = .vertical
        verticalStack.spacing = 20
        switch state {
        case .initial:
            return
        case .signIn:
            verticalStack.addArrangedSubview(signInUsernameTF)
            verticalStack.addArrangedSubview(signInPasswordTF)
            
            NSLayoutConstraint.activate([
                verticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                verticalStack.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -262),
            ])
        case .signUp:
            verticalStack.addArrangedSubview(signUpUsernameTF)
            verticalStack.addArrangedSubview(signUpPasswordTF)
            verticalStack.addArrangedSubview(signUpReEnterPasswordTF)
            
            NSLayoutConstraint.activate([
                verticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                verticalStack.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -227),
            ])
        }
    }
    
    func setupBottomView() {
        view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomView.button2Action = facebookPress
        bottomView.button1Action = googlePress
        
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    func setupSignInPasswordTF() {
        signInPasswordTF.placeholder = "Password"
        signInPasswordTF.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signInPasswordTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            signInPasswordTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            signInPasswordTF.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    func setupSignInUsernameTF() {
        signInUsernameTF.placeholder = "Username"
        signInUsernameTF.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            signInUsernameTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            signInUsernameTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            signInUsernameTF.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.font = .Roboto.bold.size(of: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        switch state {
        case .signIn:
            titleLabel.text = "Sign In"
        case .signUp:
            titleLabel.text = "Sign Up"
        case .initial:
            break
        }
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: verticalStack.topAnchor, constant: -38),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34)
        ])
    }
    func setupLogoImageView() {
        view.addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(resource: .loginLogo)
        logoImageView.layer.cornerRadius = 24
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 109),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 57),
            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -57),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
        ])
    }
    func setupSignInButton() {
        view.addSubview(signInButton)
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.setTitle("Sign In")
        signInButton.scheme = .orange
        signInButton.action = onSignInTapped
        
        switch state {
        case .initial:
            NSLayoutConstraint.activate([
                signInButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 60),
                signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                signInButton.heightAnchor.constraint(equalToConstant: 50),
            ])
        case .signIn:
            NSLayoutConstraint.activate([
                signInButton.topAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: 30),
                signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                signInButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        case .signUp:
            NSLayoutConstraint.activate([
                signInButton.topAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: 30),
                signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                signInButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
    }
    func setupSignUpButton() {
        view.addSubview(signUpButton)
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.setTitle("Sign Up")
        signUpButton.scheme = .gray
        signUpButton.action = onSignUpTapped
        
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    func setupForgotLabel() {
        view.addSubview(forgotLabel)
        forgotLabel.font = .Roboto.regular.size(of: 14)
        forgotLabel.textColor = AppColors.bottomViewGray
        forgotLabel.text = "Forgot Password?"
        forgotLabel.translatesAutoresizingMaskIntoConstraints = false
        
        switch state {
        case .signIn:
            NSLayoutConstraint.activate([
                forgotLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                forgotLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            ])
        case .signUp:
            NSLayoutConstraint.activate([
                forgotLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                forgotLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            ])
        case .initial:
            break
        }
    }
    func setupSignUpPasswordTF() {
        signUpPasswordTF.placeholder = "Enter Password"
        signUpPasswordTF.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signUpPasswordTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            signUpPasswordTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            signUpPasswordTF.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    func setupSignUpUsernameTF() {
        signUpUsernameTF.placeholder = "Enter Username"
        signUpUsernameTF.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signUpUsernameTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            signUpUsernameTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            signUpUsernameTF.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    func setupSignUpReEnterPasswordTF() {
        signUpReEnterPasswordTF.placeholder = "Re-enter Password"
        signUpReEnterPasswordTF.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signUpReEnterPasswordTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            signUpReEnterPasswordTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            signUpReEnterPasswordTF.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

// MARK: - LoginViewInput delegate
extension LoginViewController: LoginViewInput {
    func onBackPressed() {
        
    }
    
    func onSignInTapped() {
        switch state {
        case .initial:
            viewOutput.goToSignIn()
        case .signIn:
            return
        case .signUp:
            return
        }
    }
    
    func onSignUpTapped() {
        switch state {
        case .initial:
            viewOutput.goToSignUp()
        case .signIn:
            return
        case .signUp:
            return
        }
    }
    
    func onFacebookTapped() {
        
    }
    
    func onGoogleTapped() {
        
    }
    
    func onForgotTapped() {
        
    }
    
    
}

//#Preview("LoginVC") {
//    LoginViewController(viewOutput: LoginPresenter(), state: .signUp)
//}


