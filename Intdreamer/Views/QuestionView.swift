//
//  QuestionView.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 11/09/2023.
//

import UIKit

protocol QuestionViewDelegate: AnyObject {
    func didChooseOption(with answer: String)
}

class QuestionView: UIView {
    
    //MARK: - Delegate
    weak var delegate: QuestionViewDelegate?

    //MARK: - Question
    private let question: Question

    //MARK: - UI Objects
    private lazy var answersStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: optionsBtns)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var optionsBtns = setBtns()
        
    private lazy var questionLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = question.question
        lbl.font = UIFont(name: "Marker Felt", size: 24)
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.numberOfLines = 3
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    //MARK: - Actions
    @objc private func didPressOptionBtn(_ sender: OptionBtn) {
        deselectAllBtn()
        sender.selectBtn()
        delegate?.didChooseOption(with: question.answer[sender.tag])
    }
    
    //MARK: - init
    init(frame: CGRect, question: Question) {
        // set question
        self.question = question
        // super
        super.init(frame: frame)
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // settings
        backgroundColor = UIColor(named: "tintColor")!.withAlphaComponent(0.5)
        layer.borderWidth = 0.3
        layer.borderColor = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        addSubview(questionLbl)
        addSubview(answersStack)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let questionLblConstrants = [
            questionLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            questionLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            questionLbl.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            //questionLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        ]
        
        let answersStackConstraints = [
            answersStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            answersStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            answersStack.topAnchor.constraint(equalTo: questionLbl.bottomAnchor, constant: 20),
            answersStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ]

        NSLayoutConstraint.activate(questionLblConstrants)
        NSLayoutConstraint.activate(answersStackConstraints)
    }
    
    //MARK: - Set Stack
    private func setBtns() -> [OptionBtn] {
        var btns: [OptionBtn] = []
        
        for (index, option) in question.options.enumerated() {
            let btn = OptionBtn()
            btn.tag = index
            btn.titleLbl.text = option
            btn.addTarget(nil, action: #selector(didPressOptionBtn(_:)), for: .touchUpInside)
            btns.append(btn)
        }
        return btns
    }
    
    //MARK: - Deselect all
    private func deselectAllBtn() {
        for btn in optionsBtns {
            btn.deselectBtn()
        }
    }
    
    
    //MARK: - Required init
    required init?(coder: NSCoder) {
        fatalError()
    }
}
