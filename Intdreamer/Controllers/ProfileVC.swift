//
//  ProfileVC.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 27/09/2023.
//

import UIKit

class ProfileVC: UIViewController {

    //MARK: - viewModel
//    private var viewModel = DiaryViewViewModel()
//    private var subscriptions: Set<AnyCancellable> = []

    //MARK: - UI Objects
    private let profileView = ProfileView()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bg")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Actions
    @objc private func didPressInfoBtn() {
        let vc  = InfoVC()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.pushViewController(vc, animated: true)
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
    
    //MARK: - Bind views
    private func bindViews() {

    }
    
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(profileView)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let backgroundImageViewConstraints = [
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor)
        ]
        
        let profileViewConstraints = [
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
        ]
        
        NSLayoutConstraint.activate(backgroundImageViewConstraints)
        NSLayoutConstraint.activate(profileViewConstraints)
    }
    
    //MARK: - Configure nav bar
    private func configureNavBar() {
        // title
        let titleLbl: UILabel = {
            let lbl = UILabel()
            lbl.text = "Profile"
            lbl.textColor = UIColor(named: "tintColor")
            lbl.font = UIFont(name: "Marker Felt", size: 40)
            return lbl
        }()
        navigationItem.titleView = titleLbl
        
        // right btn
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "HowToUse"), style: .plain, target: self, action: #selector(didPressInfoBtn))
    }


}
