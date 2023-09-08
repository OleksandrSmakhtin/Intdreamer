//
//  PhaseVC.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 07/09/2023.
//

import UIKit
import Combine

enum CalculationStages {
    case description
    case wake
    case hours
    case sleep
}

class PhaseVC: UIViewController {
    
    //MARK: - View Model
    private var viewModel = PhaseViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    //MARK: - UI Objects
    
    private lazy var hoursPicker: HoursPicker? = nil
    
    private lazy var customLblView: CustomLableView? = nil
    
    private let continueBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Continue", for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 15
        btn.addTarget(nil, action: #selector(didPressContinueBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let descriptionLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = K.descriptionStage
        lbl.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.numberOfLines = 3
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let sleepPhaseLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Sleep Phase Calculator"
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
    
    //MARK: - Actions
    @objc private func didSaveBtn() {
        viewModel.calculatePhase()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func didPressContinueBtn() {
        let vc  = PhaseVC()
        vc.viewModel.lastStage = viewModel.currentStage
        vc.viewModel.awakeTime = viewModel.awakeTime
        vc.viewModel.sleepHours = viewModel.sleepHours
        vc.viewModel.switchStage()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didPressInfoBtn() {
        let vc  = InfoVC()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // bind views
        bindViews()
        // configure nav bar
        configureNavBar()
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // apply delegates
        applyHoursPickerDelegate()
    }
    
    //MARK: - Bind views
    private func bindViews() {
        // stage
        viewModel.$currentStage.sink { [weak self] stage in
            switch stage {
            case .description:
                self?.customLblView = CustomLableView(frame: .zero, type: .description)
                self?.customLblView?.setData(for: K.descriptionStageText)
                self?.descriptionLbl.text = K.descriptionStage
            case .wake:
                self?.descriptionLbl.text = K.wakeStage
                self?.hoursPicker = HoursPicker(frame: .zero, type: .time)
            case .hours:
                self?.descriptionLbl.text = K.hoursStage
                self?.hoursPicker = HoursPicker(frame: .zero, type: .hours)
            case .sleep:
                self?.descriptionLbl.text = K.sleepStage
                self?.hoursPicker = HoursPicker(frame: .zero, type: .sleepHours)
                self?.continueBtn.setTitle("Save", for: .normal)
                self?.continueBtn.removeTarget(nil, action: #selector(self?.didPressContinueBtn), for: .touchUpInside)
                self?.continueBtn.addTarget(nil, action: #selector(self?.didSaveBtn), for: .touchUpInside)
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
        view.addSubview(sleepPhaseLbl)
        view.addSubview(descriptionLbl)
        view.addSubview(continueBtn)
        
        switch viewModel.currentStage {
        case .description:
            view.addSubview(customLblView!)
        case .wake:
            view.addSubview(hoursPicker!)
        case .hours:
            view.addSubview(hoursPicker!)
        case .sleep:
            view.addSubview(hoursPicker!)
        }
        
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let backgroundImageViewConstraints = [
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor)
        ]
        
        let sleepPhaseLblConstraints = [
            sleepPhaseLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sleepPhaseLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        ]
        
        let descriptionLblConstraints = [
            descriptionLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            descriptionLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            descriptionLbl.topAnchor.constraint(equalTo: sleepPhaseLbl.bottomAnchor, constant: 30),
            descriptionLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let continueBtnConstraints = [
            continueBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            continueBtn.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(sleepPhaseLblConstraints)
        NSLayoutConstraint.activate(backgroundImageViewConstraints)
        NSLayoutConstraint.activate(descriptionLblConstraints)
        NSLayoutConstraint.activate(continueBtnConstraints)
        
        switch viewModel.currentStage {
        case .description:
            let customLblViewConstraints = [
                customLblView!.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                customLblView!.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                customLblView!.topAnchor.constraint(equalTo: descriptionLbl.bottomAnchor, constant: 30),
                customLblView!.bottomAnchor.constraint(equalTo: continueBtn.topAnchor, constant: -300)
            ]
            NSLayoutConstraint.activate(customLblViewConstraints)
            
        case .wake:
            let hoursPickerConstraints = [
                hoursPicker!.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                hoursPicker!.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                hoursPicker!.topAnchor.constraint(equalTo: descriptionLbl.bottomAnchor, constant: 30),
                hoursPicker!.bottomAnchor.constraint(equalTo: continueBtn.topAnchor, constant: -300)
            ]
            NSLayoutConstraint.activate(hoursPickerConstraints)
        case .hours:
            let hoursPickerConstraints = [
                hoursPicker!.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                hoursPicker!.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                hoursPicker!.topAnchor.constraint(equalTo: descriptionLbl.bottomAnchor, constant: 30),
                hoursPicker!.bottomAnchor.constraint(equalTo: continueBtn.topAnchor, constant: -300)
            ]
            NSLayoutConstraint.activate(hoursPickerConstraints)
        case .sleep:
            let hoursPickerConstraints = [
                hoursPicker!.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                hoursPicker!.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                hoursPicker!.topAnchor.constraint(equalTo: descriptionLbl.bottomAnchor, constant: 30),
                hoursPicker!.bottomAnchor.constraint(equalTo: continueBtn.topAnchor, constant: -300)
            ]
            NSLayoutConstraint.activate(hoursPickerConstraints)
        }
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
        
        // right btn
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "questionmark.circle"), style: .plain, target: self, action: #selector(didPressInfoBtn))
        
        navigationItem.titleView = lbl
    }
}

//MARK: - HoursPickerDelegate
extension PhaseVC: HoursPickerDelegate {
    // apply delegate
    private func applyHoursPickerDelegate() {
        hoursPicker?.delegate = self
    }
    // did chose
    func didChoseItem(item: String) {
        if viewModel.currentStage == .wake {
            print("Wake: \(item)")
            viewModel.awakeTime = item
        }
        
        if viewModel.currentStage == .hours {
            print("Hours: \(item)")
            viewModel.sleepHours = item
        }
    } 
}
