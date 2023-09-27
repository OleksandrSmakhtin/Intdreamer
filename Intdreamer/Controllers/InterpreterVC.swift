//
//  InterpreterVC.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 11/09/2023.
//

import UIKit
import Combine

class InterpreterVC: UIViewController {

    //MARK: - View Model
    private var viewModel = InterpreterViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    //MARK: - UI Objects
    private lazy var questionView: QuestionView? = nil
    
    private let continueBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.isHidden = true
        btn.setImage(UIImage(named: "Continue"), for: .normal)
        btn.addTarget(nil, action: #selector(didPressContinueBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
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
//        viewModel.calculatePhase()
//        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func didPressContinueBtn() {
        if viewModel.index == 4 {
            let vc  = InterpreterLoadVC()
            vc.viewModel.answers = viewModel.transitAnswers()
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc  = InterpreterVC()
            vc.viewModel.index = viewModel.index + 1
            vc.viewModel.answers = viewModel.transitAnswers()
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            navigationController?.pushViewController(vc, animated: true)
        }
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
        applyQuestionViewDelegate()
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //viewModel.getQuestion()
    }
    
    //MARK: - Bind views
    private func bindViews() {
        // index
        viewModel.$index.sink { [weak self] index in
            if index == 5 {
                
                for answer in self!.viewModel.answers {
                    print(answer)
                    print("")
                }
                
                self?.questionView = QuestionView(frame: .zero, question: (self?.viewModel.getQuestion())!)
            } else {
                self?.questionView = QuestionView(frame: .zero, question: (self?.viewModel.getQuestion())!)
            }
        }.store(in: &subscriptions)
            
        // option
        viewModel.$isOptionSelected.sink { [weak self] state in
            self?.continueBtn.isHidden = !state
        }.store(in: &subscriptions)
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(continueBtn)
        view.addSubview(questionView!)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let backgroundImageViewConstraints = [
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor)
        ]
        
        let continueBtnConstraints = [
            continueBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            continueBtn.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let questionViewConstraints = [
            questionView!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            questionView!.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            questionView!.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            questionView!.bottomAnchor.constraint(lessThanOrEqualTo: continueBtn.topAnchor, constant: -50)
        ]
        
        NSLayoutConstraint.activate(backgroundImageViewConstraints)
        NSLayoutConstraint.activate(continueBtnConstraints)
        NSLayoutConstraint.activate(questionViewConstraints)
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


//MARK: - QuestionViewDelegate
extension InterpreterVC: QuestionViewDelegate {
    // apply delegate
    private func applyQuestionViewDelegate() {
        questionView?.delegate = self
    }
    
    // did choose
    func didChooseOption(with answer: String) {
        viewModel.isOptionSelected = true
        viewModel.setAnswer(answer: answer)
    }
}
