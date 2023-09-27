//
//  ViewController.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 05/09/2023.
//

import UIKit
import CoreData
import Combine

class MainVC: UIViewController {
    
    //MARK: - View Model
    private var viewModel = MainViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []

    //MARK: - UI Objects
    private let sleepPhaseView = SleepPhaseView()
    
    private let recommendedLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Recommended sleep time:"
        lbl.textColor = .white
        lbl.font = UIFont(name: "Marker Felt", size: 20)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let phaseCalculateBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "PhaseCalculator"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(nil, action: #selector(didPressPhaseBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let interpreterBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "DreamInterpreter"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(nil, action: #selector(didPressInterpreterBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let diaryBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "GoToDiary"), for: .normal)
        btn.addTarget(nil, action: #selector(didPressDiaryBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let lastDiaryText: UITextView = {
        let view = UITextView()
        view.textColor = .white
        view.font = UIFont(name: "Optima", size: 15)
        view.backgroundColor = UIColor(named: "tintColor")!.withAlphaComponent(0.5)
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 0.5
        view.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let lastDateLbl: UILabel = {
        let lbl = UILabel()
        //lbl.text = "05/09/2023"
        lbl.textColor = .black.withAlphaComponent(0.8)
        lbl.font = UIFont(name: "Marker Felt", size: 20)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let inerpretationLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Your latest interpretation:"
        lbl.textColor = UIColor(named: "tintColor")
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
    @objc private func didPressInterpreterBtn() {
        let vc  = InterpreterVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didPressPhaseBtn() {
        let vc  = PhaseVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didPressDiaryBtn() {
        let vc  = DiaryVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didPressDailyBtn() {
        let vc  = DailyVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didPressProfileBtn() {
        let vc  = ProfileVC()
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
        // bind
        bindViews()
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getSleepPhase()
        viewModel.getInterpretations()
        viewModel.checkDaily()
        viewModel.checkOnboarding()
    }
    
    //MARK: - Bind views
    private func bindViews() {
        // sleep phase
        viewModel.$sleepPhase.sink { [weak self] sleepPhase in
            self?.sleepPhaseView.configure(with: sleepPhase)
        }.store(in: &subscriptions)
        // last diary
        viewModel.$lastDiary.sink { [weak self] lastDiary in
            guard let last = lastDiary else {
                self?.lastDiaryText.text = ""
                self?.lastDateLbl.text = "--/--/--"
                return
            }
            self?.lastDiaryText.text = last.text
            self?.lastDateLbl.text = last.date
        }.store(in: &subscriptions)
        // daily
        viewModel.$isDailyBoxOpened.sink { [weak self] state in
            self?.navigationItem.rightBarButtonItem?.isEnabled = !state
        }.store(in: &subscriptions)
        // onboarding
        viewModel.$isOnboarded.sink { [weak self] status in
            if !status {
                let vc = OnboardingVC()
                self?.navigationController?.pushViewController(vc, animated: false)
            }
        }.store(in: &subscriptions)
        // error
        viewModel.$error.sink { error in
            guard let error = error else { return }
            print(error)
        }.store(in: &subscriptions)
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
        
        let sleepPhaseViewConstraints = [
            sleepPhaseView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sleepPhaseView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sleepPhaseView.heightAnchor.constraint(equalToConstant: 130),
            sleepPhaseView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ]
        
        let recommendedLblConstraints = [
            recommendedLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            recommendedLbl.heightAnchor.constraint(equalToConstant: 15),
            recommendedLbl.bottomAnchor.constraint(equalTo: sleepPhaseView.topAnchor, constant: -20)
        ]
        
        let inerpretationLblConstraints = [
            inerpretationLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inerpretationLbl.heightAnchor.constraint(equalToConstant: 15),
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
            diaryBtn.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let interpreterBtnConstraints = [
            interpreterBtn.topAnchor.constraint(equalTo: diaryBtn.bottomAnchor, constant: 5),
            interpreterBtn.leadingAnchor.constraint(equalTo: diaryBtn.leadingAnchor, constant: -10),
            interpreterBtn.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -5),
            interpreterBtn.bottomAnchor.constraint(equalTo: recommendedLbl.topAnchor, constant: -5)
        ]
        
        let phaseCalculateBtnConstraints = [
            phaseCalculateBtn.trailingAnchor.constraint(equalTo: diaryBtn.trailingAnchor, constant: 10),
            phaseCalculateBtn.topAnchor.constraint(equalTo: interpreterBtn.topAnchor),
            phaseCalculateBtn.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 5),
            phaseCalculateBtn.bottomAnchor.constraint(equalTo: interpreterBtn.bottomAnchor)
        ]
        
        
        
        
        
        NSLayoutConstraint.activate(backgroundImageViewConstraints)
        NSLayoutConstraint.activate(sleepPhaseViewConstraints)
        NSLayoutConstraint.activate(recommendedLblConstraints)
        
        
        NSLayoutConstraint.activate(inerpretationLblConstraints)
        NSLayoutConstraint.activate(lastDateLblConstraints)
        NSLayoutConstraint.activate(lastDiaryTextConstraints)
        NSLayoutConstraint.activate(diaryBtnConstraints)
        NSLayoutConstraint.activate(interpreterBtnConstraints)
        NSLayoutConstraint.activate(phaseCalculateBtnConstraints)
        
        
        
    }

    
    //MARK: - Configure nav bar
    private func configureNavBar() {
        // title
        let titleLbl: UILabel = {
            let lbl = UILabel()
            lbl.text = "Menu"
            lbl.textColor = UIColor(named: "tintColor")
            lbl.font = UIFont(name: "Marker Felt", size: 40)
            return lbl
        }()
        navigationItem.titleView = titleLbl
        // tint
        navigationController?.navigationBar.tintColor = .black
        
        
        // left btn
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "User"), style: .plain, target: self, action: #selector(didPressProfileBtn))
        // right btn
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Daily"), style: .plain, target: self, action: #selector(didPressDailyBtn))
        // back btn
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Back")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Back")
    }

}

