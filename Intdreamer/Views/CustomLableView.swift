//
//  CustomLableView.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 07/09/2023.
//

import UIKit

enum TextStyle {
    case description
    case diary
    case interpretation
}

class CustomLableView: UIView {

    //MARK: - UI Objects
    
    private let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Your interpretation"
        lbl.font = UIFont(name: "Marker Felt", size: 24)
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let dateLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Marker Felt", size: 22)
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Marker Felt", size: 22)
        lbl.textColor = .white
        lbl.text = UserDefaults.standard.string(forKey: "nickname")
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 30
        imageView.layer.borderWidth = 0.3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        let data = UserDefaults.standard.data(forKey: "avatar")
        imageView.image = UIImage(data: data!)
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let descriptionLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white.withAlphaComponent(0.7)
        lbl.font = UIFont(name: "Optima", size: 24)
        lbl.adjustsFontSizeToFitWidth = true
        //lbl.minimumScaleFactor = 0.5
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    //MARK: - init
    init(frame: CGRect, type: TextStyle) {
        super.init(frame: frame)
        // add subviews
        addSubviews(for: type)
        // apply constraints
        applyConstraints(for: type)
        // settings
        backgroundColor = UIColor(named: "tintColor")!.withAlphaComponent(0.5)
        layer.borderWidth = 0.3
        layer.borderColor = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Add subviews
    private func addSubviews(for type: TextStyle) {
        switch type {
        case .description:
            addSubview(descriptionLbl)
        case .diary:
            addSubview(avatarImageView)
            addSubview(dateLbl)
            addSubview(nameLbl)
            addSubview(descriptionLbl)
        case .interpretation:
            addSubview(titleLbl)
            addSubview(descriptionLbl)
        }
    }
    
    //MARK: - Apply constraints
    private func applyConstraints(for type: TextStyle) {
        switch type {
        case .description:
            let descriptionLblConstraints = [
                descriptionLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                descriptionLbl.topAnchor.constraint(equalTo: topAnchor, constant: 20),
                descriptionLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                descriptionLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
            ]
            NSLayoutConstraint.activate(descriptionLblConstraints)
        case .diary:
            let avatarImageViewConstraints = [
                avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
                avatarImageView.heightAnchor.constraint(equalToConstant: 60),
                avatarImageView.widthAnchor.constraint(equalToConstant: 60)
            ]
            
            let dateLblConstraints = [
                dateLbl.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
                dateLbl.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor)
            ]
            
            let nameLblConstraints = [
                nameLbl.leadingAnchor.constraint(equalTo: dateLbl.leadingAnchor),
                nameLbl.bottomAnchor.constraint(equalTo: dateLbl.topAnchor, constant: -10)
            ]
            
            let descriptionLblConstraints = [
                descriptionLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                descriptionLbl.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
                descriptionLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                descriptionLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
            ]
            
            NSLayoutConstraint.activate(avatarImageViewConstraints)
            NSLayoutConstraint.activate(dateLblConstraints)
            NSLayoutConstraint.activate(nameLblConstraints)
            NSLayoutConstraint.activate(descriptionLblConstraints)
        case .interpretation:
            let titleLblConstraints = [
                titleLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
                titleLbl.topAnchor.constraint(equalTo: topAnchor, constant: 20)
            ]
            
            let descriptionLblConstraints = [
                descriptionLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                descriptionLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 10),
                descriptionLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                descriptionLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
            ]
            NSLayoutConstraint.activate(titleLblConstraints)
            NSLayoutConstraint.activate(descriptionLblConstraints)
        }
    }
    
    
    //MARK: - Set data
    public func setData(for description: String, and date: String = "") {
        descriptionLbl.text = description
        dateLbl.text = date
    }
    
    //MARK: - Required init
    required init?(coder: NSCoder) {
        fatalError()
    }

}
