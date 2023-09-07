//
//  ViewController.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 05/09/2023.
//

import UIKit

class MainVC: UIViewController {

    //MARK: - UI Objects
    private let sleepPhaseView = SleepPhaseView()
    
    private let recommendedLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Recommended sleep time:"
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let phaseCalculateBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .black.withAlphaComponent(0.2)
        btn.layer.cornerRadius = 20
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let interpreterBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .black.withAlphaComponent(0.2)
        btn.layer.cornerRadius = 20
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let diaryBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Go to diary", for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 15
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let lastDiaryText: UITextView = {
        let view = UITextView()
        view.text = "Based on your neutral morning feeling, it is possible that the emotions experienced in your dream were not particularly intense. This could suggest that the themes and events in your dream may not have had a significant impact on your overall mood upon waking. It is important to note that dreams can vary in emotional intensity and may not always directly correlate with our waking emotions. In analyzing the dream based on the artifacts you provided, it is difficult to pinpoint the exact interpretation without more specific details. However, it is possible that the dream signifies a sense of neutrality or contentment in your waking life, as opposed to an underlying stress or concern. It could be a reflection of a balanced and stable mindset, where your"
        view.textColor = .white.withAlphaComponent(0.7)
        view.font = UIFont.systemFont(ofSize: 15)
        view.backgroundColor = .black.withAlphaComponent(0.2)
        view.layer.cornerRadius = 17
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let lastDateLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "05/09/2023"
        lbl.textColor = .black.withAlphaComponent(0.8)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let inerpretationLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Your latest interpretation:"
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
    
    //MARK: - Actions
    @objc private func didPressInfoBtn() {
        let vc  = InfoVC()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // bg
        view.backgroundColor = .white
        // nav bar
        configureNavBar()
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(inerpretationLbl)
        view.addSubview(lastDateLbl)
        view.addSubview(lastDiaryText)
        view.addSubview(diaryBtn)
        view.addSubview(interpreterBtn)
        view.addSubview(phaseCalculateBtn)
        view.addSubview(recommendedLbl)
        view.addSubview(sleepPhaseView)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let backgroundImageViewConstraints = [
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor)
        ]
        
        let inerpretationLblConstraints = [
            inerpretationLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inerpretationLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ]
        
        let lastDateLblConstraints = [
            lastDateLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lastDateLbl.centerYAnchor.constraint(equalTo: inerpretationLbl.centerYAnchor)
        ]
        
        let lastDiaryTextConstraints = [
            lastDiaryText.topAnchor.constraint(equalTo: inerpretationLbl.bottomAnchor, constant: 20),
            lastDiaryText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lastDiaryText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lastDiaryText.heightAnchor.constraint(equalToConstant: 80)
        ]
        
        let diaryBtnConstraints = [
            diaryBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            diaryBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            diaryBtn.topAnchor.constraint(equalTo: lastDiaryText.bottomAnchor, constant: 15),
            diaryBtn.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let interpreterBtnConstraints = [
            interpreterBtn.topAnchor.constraint(equalTo: diaryBtn.bottomAnchor, constant: 15),
            interpreterBtn.leadingAnchor.constraint(equalTo: diaryBtn.leadingAnchor),
            interpreterBtn.widthAnchor.constraint(equalTo: diaryBtn.widthAnchor, multiplier: 0.5, constant: -20),
            interpreterBtn.heightAnchor.constraint(equalTo: diaryBtn.widthAnchor, multiplier: 0.6)
        ]
        
        let phaseCalculateBtnConstraints = [
            phaseCalculateBtn.trailingAnchor.constraint(equalTo: diaryBtn.trailingAnchor),
            phaseCalculateBtn.topAnchor.constraint(equalTo: interpreterBtn.topAnchor),
            phaseCalculateBtn.heightAnchor.constraint(equalTo: interpreterBtn.heightAnchor),
            phaseCalculateBtn.widthAnchor.constraint(equalTo: interpreterBtn.widthAnchor)
        ]
        
        let recommendedLblConstraints = [
            recommendedLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recommendedLbl.topAnchor.constraint(equalTo: phaseCalculateBtn.bottomAnchor, constant: 20)
        ]
        
        let sleepPhaseViewConstraints = [
            sleepPhaseView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sleepPhaseView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sleepPhaseView.topAnchor.constraint(equalTo: recommendedLbl.bottomAnchor, constant: 20),
            sleepPhaseView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130)
            
        ]
        
        NSLayoutConstraint.activate(backgroundImageViewConstraints)
        NSLayoutConstraint.activate(inerpretationLblConstraints)
        NSLayoutConstraint.activate(lastDateLblConstraints)
        NSLayoutConstraint.activate(lastDiaryTextConstraints)
        NSLayoutConstraint.activate(diaryBtnConstraints)
        NSLayoutConstraint.activate(interpreterBtnConstraints)
        NSLayoutConstraint.activate(phaseCalculateBtnConstraints)
        NSLayoutConstraint.activate(recommendedLblConstraints)
        NSLayoutConstraint.activate(sleepPhaseViewConstraints)
    }

    
    //MARK: - Configure nav bar
    private func configureNavBar() {
        // title
        title = "Intdreamer"
        // tint
        navigationController?.navigationBar.tintColor = .black
        // left btn
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "questionmark.circle"), style: .plain, target: self, action: #selector(didPressInfoBtn))
        // right btn
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "circle.circle"), style: .plain, target: nil, action: nil)
    }

}

