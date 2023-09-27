//
//  LoadVC.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 27/09/2023.
//

import UIKit

class LoadVC: UIViewController {

    //MARK: - UI Objects
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Zeus")
        imageView.contentMode = .scaleAspectFit
        //imageView.layer.opacity = 0.0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bg")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // animate
        animateLoad()
    }

    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(backgroundImage)
        view.addSubview(logoImageView)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let backgroundImageConstraints = [
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let logoImageViewConstraints = [
            logoImageView.heightAnchor.constraint(equalToConstant: 300),
            logoImageView.widthAnchor.constraint(equalToConstant: 300),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(backgroundImageConstraints)
        NSLayoutConstraint.activate(logoImageViewConstraints)
    }
    
    //MARK: - Animate load
    private func animateLoad() {
        UIView.animate(withDuration: 1.1) { [weak self] in
            self?.logoImageView.layer.opacity = 0.0
        } completion: { _ in
            UIView.animate(withDuration: 1.1) { [weak self] in
                self?.logoImageView.layer.opacity = 1.0
            } completion: { [weak self] _ in
                let vc = UINavigationController(rootViewController: MainVC())
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: false)
            }
        }
    }
}
