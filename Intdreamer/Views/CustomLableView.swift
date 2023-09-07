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
    private let dateLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "05.06.2023"
        lbl.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let descriptionLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Based on your neutral morning feeling, it is possible that the emotions experienced in your dream were not particularly intense. This could suggest that the themes and events in your dream may not have had a significant impact on your overall mood upon waking. It is important to note that dreams can vary in emotional intensity and may not always directly correlate with our waking emotions. In analyzing the dream based on the artifacts you provided, it is difficult to pinpoint the exact interpretation without more specific details. However, it is possible that the dream signifies a sense of neutrality or contentment in your waking life, as opposed to an underlying stress or concern. It could be a reflection of a balanced and stable mindset, where your"
        lbl.textColor = .white.withAlphaComponent(0.7)
        lbl.font = UIFont.systemFont(ofSize: 20)
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
        backgroundColor = .black.withAlphaComponent(0.2)
        layer.cornerRadius = 20
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
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
            Void()
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
                descriptionLbl.topAnchor.constraint(equalTo: dateLbl.bottomAnchor, constant: 10),
                descriptionLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                descriptionLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
            ]
            
            NSLayoutConstraint.activate(dateLblConstraints)
            NSLayoutConstraint.activate(descriptionLblConstraints)
        case .interpretation:
            Void()
        }
    }
    
    
    //MARK: - Set data
    public func setData(for description: String, and date: String) {
        descriptionLbl.text = description
        dateLbl.text = date
    }
    
    //MARK: - Required init
    required init?(coder: NSCoder) {
        fatalError()
    }

}
