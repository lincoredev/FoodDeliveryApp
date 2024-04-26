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
    func startLoader()
    func stopLoader()
}

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    private var state: LoginViewState = .initial
    var viewOutput: LoginViewOutput!
    private var isKeyboardShown = false
    private var bottomCTValue = 0.0
    
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
    private lazy var stackViewBottomCT = NSLayoutConstraint()
    private lazy var loader = UIActivityIndicatorView(style: .large)
    private lazy var loaderContainer = UIView()
    
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
        setupObservers()
        
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    deinit {
        stopKeyboardListener()
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
            navigationItem.setHidesBackButton(true, animated: true)
            
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
            setupNavigationBar()
        case .signUp:
            setupBottomView()
            setupStack()
            setupSignUpPasswordTF()
            setupSignUpUsernameTF()
            setupSignUpReEnterPasswordTF()
            setupTitleLabel()
            setupSignInButton()
            setupForgotLabel()
            setupNavigationBar()
        }
        setupLoaderView()
    }
    func setupNavigationBar() {
        let backImage = UIImage(resource: .back)
        let backButtonItem = UIBarButtonItem(image: backImage,
                                             style: .plain,
                                             target: navigationController,
                                             action: #selector(navigationController?.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backButtonItem
        navigationItem.leftBarButtonItem?.tintColor = AppColors.black
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
            bottomCTValue = -262
            stackViewBottomCT = verticalStack.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: bottomCTValue)
            
            NSLayoutConstraint.activate([
                verticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                stackViewBottomCT
            ])
        case .signUp:
            verticalStack.addArrangedSubview(signUpUsernameTF)
            verticalStack.addArrangedSubview(signUpPasswordTF)
            verticalStack.addArrangedSubview(signUpReEnterPasswordTF)
            bottomCTValue = -227
            stackViewBottomCT = verticalStack.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: bottomCTValue)
            
            NSLayoutConstraint.activate([
                verticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                stackViewBottomCT
            ])
        }
    }
    func setupBottomView() {
        view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomView.button2Action = { [ weak self] in
            self?.facebookPress()
        }
        bottomView.button1Action = { [ weak self] in
            self?.googlePress()
        }
        
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
        signInButton.action = { [weak self] in
            self?.onSignInTapped()
        }
        
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
        signUpButton.action = { [weak self] in
            self?.onSignUpTapped()
        }
        
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
    func setupLoaderView() {
        view.addSubview(loaderContainer)
        loaderContainer.translatesAutoresizingMaskIntoConstraints = false
        loaderContainer.backgroundColor = AppColors.black.withAlphaComponent(0.3)
        loaderContainer.isHidden = true
        
        NSLayoutConstraint.activate([
            loaderContainer.widthAnchor.constraint(equalTo: view.widthAnchor),
            loaderContainer.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])
        
        loader.translatesAutoresizingMaskIntoConstraints = false
        loaderContainer.addSubview(loader)
        
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: loaderContainer.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: loaderContainer.centerYAnchor),
        ])
    }
}

// MARK: - Keyboard Observers
private extension LoginViewController {
    func setupObservers() {
        startKeyboardListener()
    }
    func startKeyboardListener() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    func stopKeyboardListener() {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardHeight = keyboardFrame.cgRectValue.height
        
        if !isKeyboardShown {
            UIView.animate(withDuration: 0.3) {
                self.stackViewBottomCT.constant -= keyboardHeight/4
                self.view.layoutIfNeeded()
                self.isKeyboardShown = true
            }
        }
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        if isKeyboardShown {
            UIView.animate(withDuration: 0.3) {
                self.stackViewBottomCT.constant = self.bottomCTValue
                self.view.layoutIfNeeded()
                self.isKeyboardShown = false
            }
        }
    }
}

// MARK: - Private methods
private extension LoginViewController {
    
    func onBackPressed() {
        
    }
    
    func onSignInTapped() {
        switch state {
        case .initial:
            viewOutput.goToSignIn()
        case .signIn:
            print(#function)
            viewOutput.loginStart(login: signInUsernameTF.text ?? "", password: signInPasswordTF.text ?? "")
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

// MARK: - LoginViewInput delegate
extension LoginViewController: LoginViewInput {
    func startLoader() {
        loaderContainer.isHidden = false
        loader.startAnimating()
    }
    
    func stopLoader() {
        loaderContainer.isHidden = true
        loader.stopAnimating()
    }
    
    
}



//#Preview("LoginVC") {
//    LoginViewController(viewOutput: LoginPresenter(), state: .signUp)
//}


