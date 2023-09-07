//
//  SleepPhaseView.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 05/09/2023.
//

import UIKit

class SleepPhaseView: UIView {

    //MARK: - UI Objects
    private let sunImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.image = UIImage(systemName: "sun.max.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let moonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.image = UIImage(systemName: "moon.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        // settings
        backgroundColor = .black.withAlphaComponent(0.6)
        layer.cornerRadius = 20
        translatesAutoresizingMaskIntoConstraints = false
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
    }

    //MARK: - Add subviews
    private func addSubviews() {
        addSubview(moonImageView)
        addSubview(sunImageView)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let moonImageViewConstraints = [
            moonImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            moonImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ]
        
        let sunImageViewConstraints = [
            sunImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            sunImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ]
        
        NSLayoutConstraint.activate(moonImageViewConstraints)
        NSLayoutConstraint.activate(sunImageViewConstraints)
    }
    
    //MARK: - Required init
    required init?(coder: NSCoder) {
        fatalError()
    }
}
