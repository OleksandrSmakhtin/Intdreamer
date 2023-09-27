//
//  OnboardingVC.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 14/09/2023.
//

import UIKit
import Combine

class OnboardingVC: UIViewController {
    
    //MARK: - viewModel
    private var viewModel = OnboardingViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []

    //MARK: - UI Objects
    private let addPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = UIImage(named: "AddPhoto")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white.withAlphaComponent(0.2)
        textField.layer.borderWidth = 3
        textField.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 50))
        textField.leftViewMode = .always
        textField.font = UIFont(name: "Marker Felt", size: 18)
        textField.textColor = .white
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "Marker Felt", size: 18) as Any
        ]
        textField.autocorrectionType = .no
        textField.attributedPlaceholder = NSAttributedString(string: "Nick name", attributes: attributes)
        textField.tintColor = .white
        textField.addTarget(nil, action: #selector(didChangeTextField), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let onboardingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "tintColor")?.withAlphaComponent(0.5)
        view.layer.borderWidth = 0.3
        view.layer.borderColor = UIColor.white.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let continueBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "Continue"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(nil, action: #selector(didPressContinue), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bg")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Actions
    @objc private func didPressContinue() {
        viewModel.saveDetails()
    }
    
    @objc private func didChangeTextField() {
        guard let text = nameField.text else { return }
        viewModel.nickname = text
    }
    
    @objc private func dissmissAction() {
        view.endEditing(true)
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // configure nav bar
        configureNavBar()
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // bind views
        bindViews()
    }
    
    //MARK: - Bind Views
    private func bindViews() {
        // avatar
        viewModel.$avatar.sink { [weak self] avatar in
            guard let avatar = avatar else { return }
            self?.addPhotoImageView.image = avatar
        }.store(in: &subscriptions)
        
        // is onboarded
        viewModel.$isOnboarded.sink { [weak self] status in
            if status {
                self?.navigationController?.popViewController(animated: true)
            }
        }.store(in: &subscriptions)
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dissmissAction)))
        view.addSubview(onboardingView)
        view.addSubview(nameField)
        view.addSubview(addPhotoImageView)
        view.addSubview(continueBtn)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let backgroundImageViewConstraints = [
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor)
        ]
        
        let onboardingViewConstraints = [
            onboardingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            onboardingView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            onboardingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 130),
            onboardingView.heightAnchor.constraint(equalToConstant: 280)
        ]
        
        let nameFieldConstraints = [
            nameField.leadingAnchor.constraint(equalTo: onboardingView.leadingAnchor, constant: 30),
            nameField.trailingAnchor.constraint(equalTo: onboardingView.trailingAnchor, constant: -30),
            nameField.bottomAnchor.constraint(equalTo: onboardingView.bottomAnchor, constant: -40),
            nameField.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let addPhotoImageViewConstraints = [
            addPhotoImageView.topAnchor.constraint(equalTo: onboardingView.topAnchor, constant: 30),
            addPhotoImageView.centerXAnchor.constraint(equalTo: onboardingView.centerXAnchor),
            addPhotoImageView.bottomAnchor.constraint(equalTo: nameField.topAnchor, constant: -30)
        ]
        
        let continueBtnConstraints = [
            continueBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueBtn.topAnchor.constraint(equalTo: onboardingView.bottomAnchor, constant: 20)
        ]
        
        NSLayoutConstraint.activate(backgroundImageViewConstraints)
        NSLayoutConstraint.activate(onboardingViewConstraints)
        NSLayoutConstraint.activate(nameFieldConstraints)
        NSLayoutConstraint.activate(addPhotoImageViewConstraints)
        NSLayoutConstraint.activate(continueBtnConstraints)
    }
    

    //MARK: - Configure nav bar
    private func configureNavBar() {
        // title
        let titleLbl: UILabel = {
            let lbl = UILabel()
            lbl.text = "Account"
            lbl.textColor = UIColor(named: "tintColor")
            lbl.font = UIFont(name: "Marker Felt", size: 40)
            return lbl
        }()
        navigationItem.titleView = titleLbl
        navigationItem.hidesBackButton = true
    }
}
