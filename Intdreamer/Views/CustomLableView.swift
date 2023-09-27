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
        lbl.font = UIFont(name: "Marker Felt", size: 24)
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
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
            addSubview(dateLbl)
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
            let dateLblConstraints = [
                dateLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                dateLbl.topAnchor.constraint(equalTo: topAnchor, constant: 20)
            ]
            
            let descriptionLblConstraints = [
                descriptionLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                descriptionLbl.topAnchor.constraint(equalTo: dateLbl.bottomAnchor, constant: 20),
                descriptionLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                descriptionLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
            ]
            
            NSLayoutConstraint.activate(dateLblConstraints)
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
