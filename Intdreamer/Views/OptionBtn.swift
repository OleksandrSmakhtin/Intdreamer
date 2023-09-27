//
//  QuestionBtn.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 11/09/2023.
//

import UIKit

class OptionBtn: UIButton {
    
    //MARK: - UI Objects
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Optima", size: 18)
        lbl.textColor = .white
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 12.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // settings
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        addSubview(circleView)
        addSubview(titleLbl)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let titleLblConstraints = [
            titleLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            titleLbl.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ]
        
        let circleViewConstraints = [
            circleView.widthAnchor.constraint(equalToConstant: 25),
            circleView.heightAnchor.constraint(equalToConstant: 25),
            circleView.centerYAnchor.constraint(equalTo: titleLbl.centerYAnchor),
            circleView.trailingAnchor.constraint(equalTo: titleLbl.leadingAnchor, constant: -10),
            circleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5)
        ]
        
        NSLayoutConstraint.activate(titleLblConstraints)
        NSLayoutConstraint.activate(circleViewConstraints)
    }
    
    public func selectBtn() {
        circleView.backgroundColor = .white
    }
    
    public func deselectBtn() {
        circleView.backgroundColor = .clear
    }
    
    //MARK: - Required init
    required init?(coder: NSCoder) {
        fatalError()
    }

}
