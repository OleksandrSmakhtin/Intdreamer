//
//  DailyVC.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 08/09/2023.
//

import UIKit
import Combine

class DailyVC: UIViewController {
    
    //MARK: - UI Objects
    private let tapToOpenLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Tap to open"
        lbl.textColor = UIColor(named: "tintColor")
        lbl.font = UIFont(name: "Optima", size: 20)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let boxImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Box")
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let topLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Your daily message:"
        lbl.textColor = UIColor(named: "tintColor")
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Marker Felt", size: 22)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bg")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Actions
    @objc private func didTapBox() {
        boxImageView.image = UIImage(named: "OpenBox")
        tapToOpenLbl.text = K.dailyMessages.randomElement()
        tapToOpenLbl.font = UIFont(name: "Marker Felt", size: 18)
        tapToOpenLbl.textColor = .white
        
        let currentDate = Date()
        UserDefaults.standard.set(currentDate, forKey: "lastOpenedDailyBoxScreen")
        let score = UserDefaults.standard.integer(forKey: "dailyScore")
        UserDefaults.standard.setValue(score + 1, forKey: "dailyScore")
        boxImageView.isUserInteractionEnabled = false
    }
    
    @objc private func didPressInfoBtn() {
        let vc  = InfoVC()
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
        // add image target
        boxImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapBox)))
        
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(topLbl)
        view.addSubview(tapToOpenLbl)
        view.addSubview(boxImageView)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let backgroundImageViewConstraints = [
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor)
        ]
        
        let topLblConstraints = [
            topLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60)
        ]
        
        let tapToOpenConstraints = [
            tapToOpenLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tapToOpenLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tapToOpenLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tapToOpenLbl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ]
        
        let loadImageViewConstraints = [
            boxImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            boxImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            boxImageView.topAnchor.constraint(equalTo: topLbl.bottomAnchor, constant: 30),
            boxImageView.bottomAnchor.constraint(equalTo: tapToOpenLbl.topAnchor, constant: -30)
        ]

        NSLayoutConstraint.activate(backgroundImageViewConstraints)
        NSLayoutConstraint.activate(topLblConstraints)
        NSLayoutConstraint.activate(tapToOpenConstraints)
        NSLayoutConstraint.activate(loadImageViewConstraints)
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
        // right btn
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "HowToUse"), style: .plain, target: self, action: #selector(didPressInfoBtn))
    }
}
