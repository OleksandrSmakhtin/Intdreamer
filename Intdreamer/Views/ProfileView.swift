//
//  ProfileView.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 27/09/2023.
//

import UIKit

class ProfileView: UIView {

    //MARK: - UI Objects
    private lazy var statLbls = setStats()
    
    private lazy var statsStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: statLbls)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 40
        imageView.layer.borderWidth = 0.3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let editAvatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "pencil", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))
        imageView.tintColor = UIColor(named: "tintColor")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        // sett
        backgroundColor = UIColor(named: "tintColor")!.withAlphaComponent(0.5)
        layer.borderWidth = 0.3
        layer.borderColor = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // configure user data
        configureUserData()
        
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        addSubview(avatarImageView)
        addSubview(editAvatarImageView)
        addSubview(statsStack)
        
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let avatarImageViewConstraints = [
            avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            avatarImageView.heightAnchor.constraint(equalToConstant: 80),
            avatarImageView.widthAnchor.constraint(equalToConstant: 80)
        ]
        
        let editAvatarImageViewConstraints = [
            editAvatarImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 3),
            editAvatarImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            editAvatarImageView.heightAnchor.constraint(equalToConstant: 30),
            editAvatarImageView.widthAnchor.constraint(equalToConstant: 30)
        ]
        
        let statsStackConstraints = [
            statsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            statsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            statsStack.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
            statsStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(avatarImageViewConstraints)
        NSLayoutConstraint.activate(editAvatarImageViewConstraints)
        NSLayoutConstraint.activate(statsStackConstraints)
    }
    
    
    //MARK: - Set stats
    private func setStats() -> [UILabel] {
        var lbls = [UILabel]()
        for (index, stat) in K.stats.enumerated() {
            let lbl = UILabel()
            switch index {
            case 0:
                lbl.text = "\(stat)\(UserDefaults.standard.integer(forKey: "diaryPages"))"
            case 1:
                lbl.text = "\(stat)\(UserDefaults.standard.integer(forKey: "totalInt"))"
            case 2:
                lbl.text = "\(stat)\(UserDefaults.standard.integer(forKey: "totalPhase"))"
            default:
                lbl.text = ""
            }
            lbl.font = UIFont(name: "Optima", size: 18)
            lbl.textColor = .white
            lbls.append(lbl)
        }
        return lbls
    }
    
    //MARK: - Configure user
    private func configureUserData() {
        // nickname
//        if let nickname = UserDefaults.standard.string(forKey: "UserName") {
//            nameField.text = nickname
//        }
        
        // avatar
        guard let data = UserDefaults.standard.data(forKey: "avatar") else {
            avatarImageView.image = UIImage(named: "photo")
            return }
        guard let avatarImage = UIImage(data: data) else { return }
        avatarImageView.image = avatarImage
    }
    
    //MARK: - Required init
    required init?(coder: NSCoder) {
        fatalError()
    }
}
