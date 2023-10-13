//
//  ProfileView.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 27/09/2023.
//

import UIKit
import AVFoundation

protocol ProfileViewDelegate: AnyObject {
    func didChangeTextField(text: String)
    func didTapOnAvatar()
    func didSelectPrivacy()
}

class ProfileView: UIView {

    //MARK: - Delegate
    weak var delegate: ProfileViewDelegate?
    
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
    
    private let privacyBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .white
        let attributedText = NSMutableAttributedString(string: "Privacy")
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: "Privacy".count))
        btn.addTarget(nil, action: #selector(didTapPrivacy), for: .touchUpInside)
        btn.setAttributedTitle(attributedText, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 40
        imageView.layer.borderWidth = 0.3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
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
        textField.attributedPlaceholder = NSAttributedString(string: "", attributes: attributes)
        textField.tintColor = .white
        textField.addTarget(nil, action: #selector(didChangeTextField), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    //MARK: - Actions
    @objc private func didTapPrivacy() {
        delegate?.didSelectPrivacy()
    }
    
    @objc private func didPressOnAvatar() {
        delegate?.didTapOnAvatar()
    }
    
    @objc private func didChangeTextField() {
        guard let text = nameField.text else { return }
        delegate?.didChangeTextField(text: text)
    }
    
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
        avatarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didPressOnAvatar)))
        addSubview(editAvatarImageView)
        addSubview(nameField)
        addSubview(privacyBtn)
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
        
        let nameFieldConstraints = [
            nameField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            nameField.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
            nameField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            nameField.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let privacyBtnConstraints = [
            privacyBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
            privacyBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ]
        
        let statsStackConstraints = [
            statsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            statsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            statsStack.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            statsStack.bottomAnchor.constraint(equalTo: privacyBtn.topAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(avatarImageViewConstraints)
        NSLayoutConstraint.activate(editAvatarImageViewConstraints)
        NSLayoutConstraint.activate(nameFieldConstraints)
        NSLayoutConstraint.activate(privacyBtnConstraints)
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
                lbl.text = "\(stat)\(UserDefaults.standard.integer(forKey: "dailyScore"))"
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
        if let nickname = UserDefaults.standard.string(forKey: "nickname") {
            nameField.text = nickname
        }
        
        // avatar
        guard let data = UserDefaults.standard.data(forKey: "avatar") else {
            avatarImageView.image = UIImage(named: "photo")
            return }
        guard let avatarImage = UIImage(data: data) else { return }
        avatarImageView.image = avatarImage
    }
    
    //MARK: - Change image
    public func changeImage(on image: UIImage) {
        avatarImageView.image = image
    }
    
    //MARK: - Nickname count
    public func getNicknameCount() -> Int {
        guard let count = nameField.text?.count else { return 0 }
        return count
    }
    
    //MARK: - Required init
    required init?(coder: NSCoder) {
        fatalError()
    }
}
