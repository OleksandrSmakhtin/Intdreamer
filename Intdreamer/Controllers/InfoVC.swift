//
//  InfoVC.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 07/09/2023.
//

import UIKit

class InfoVC: UIViewController {
    
    //MARK: - UI Objects
    private let descriptionView = CustomLableView(frame: .zero, type: .description)
    
    private let howToUseLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "How to use Intdreamer"
        lbl.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        lbl.textColor = .black
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
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // configure nav bar
        configureNavBar()
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        
        
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(howToUseLbl)
        view.addSubview(descriptionView)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let backgroundImageViewConstraints = [
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor)
        ]
        
        let howToUseLblConstraints = [
            howToUseLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            howToUseLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ]
        
        let descriptionViewConstraints = [
            descriptionView.topAnchor.constraint(equalTo: howToUseLbl.bottomAnchor, constant: 20),
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(backgroundImageViewConstraints)
        NSLayoutConstraint.activate(howToUseLblConstraints)
        NSLayoutConstraint.activate(descriptionViewConstraints)
    }
    
    //MARK: - Configure nav bar
    private func configureNavBar() {
        // title view
        let lbl: UILabel = {
            let lbl = UILabel()
            lbl.text = "Intdreamer"
            lbl.textColor = .black
            lbl.font = UIFont.systemFont(ofSize: 25)
            return lbl
        }()
        
        navigationItem.titleView = lbl
    }
    

}
