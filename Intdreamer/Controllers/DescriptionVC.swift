//
//  DescriptionVC.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 12/09/2023.
//

import UIKit
import Combine

class DescriptionVC: UIViewController {
    
    //MARK: - View Model
    var viewModel = InterpreterViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []

    //MARK: - UI Objects
    private let customLableView = CustomLableView(frame: .zero, type: .interpretation)
    
    private let saveToDiaryBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "SaveToDiary"), for: .normal)
        btn.addTarget(nil, action: #selector(didPressSaveBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let menuBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "Menu"), for: .normal)
        btn.addTarget(nil, action: #selector(didPressMenuBtn), for: .touchUpInside)
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
    @objc private func didPressSaveBtn() {
        viewModel.saveToDiary()
    }
    
    @objc private func didPressMenuBtn() {
        navigationController?.popToRootViewController(animated: true)
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
        // configure description
        configureDescription()
        // bind views
        bindViews()
    }
    
    //MARK: - Bind views
    private func bindViews() {
        viewModel.$isSaved.sink { [weak self] state in
            if state {
                let total = UserDefaults.standard.integer(forKey: "diaryPages")
                UserDefaults.standard.setValue(total + 1, forKey: "diaryPages")
                self?.navigationController?.popToRootViewController(animated: true)
            }
        }.store(in: &subscriptions)
    }

    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(menuBtn)
        view.addSubview(saveToDiaryBtn)
        view.addSubview(customLableView)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let backgroundImageViewConstraints = [
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor)
        ]
        
        let continueBtnConstraints = [
            menuBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            menuBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            menuBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            menuBtn.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let saveToDiaryBtnConstraints = [
            saveToDiaryBtn.leadingAnchor.constraint(equalTo: menuBtn.leadingAnchor),
            saveToDiaryBtn.trailingAnchor.constraint(equalTo: menuBtn.trailingAnchor),
            saveToDiaryBtn.bottomAnchor.constraint(equalTo: menuBtn.topAnchor, constant: -10),
            saveToDiaryBtn.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let customLableViewConstraints = [
            customLableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            customLableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            customLableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            customLableView.bottomAnchor.constraint(lessThanOrEqualTo: saveToDiaryBtn.topAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(backgroundImageViewConstraints)
        NSLayoutConstraint.activate(continueBtnConstraints)
        NSLayoutConstraint.activate(saveToDiaryBtnConstraints)
        NSLayoutConstraint.activate(customLableViewConstraints)
    }
    
    //MARK: - Configure description
    private func configureDescription() {
        customLableView.setData(for: viewModel.getFullMessage())
    }

    
    //MARK: - Configure nav bar
    private func configureNavBar() {
        // title
        let titleLbl: UILabel = {
            let lbl = UILabel()
            lbl.text = "Interpreter"
            lbl.textColor = UIColor(named: "tintColor")
            lbl.font = UIFont(name: "Marker Felt", size: 40)
            return lbl
        }()
        navigationItem.titleView = titleLbl
        navigationItem.hidesBackButton = true
    }
}
