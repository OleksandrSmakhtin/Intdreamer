//
//  SleepPhaseView.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 05/09/2023.
//

import UIKit
import CoreData

class SleepPhaseView: UIView {

    //MARK: - UI Objects
    private let hoursLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "9"
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 23, weight: .medium)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let awakeningValueLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "07:00"
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 20)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let awakeningLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Awakening:"
        lbl.textColor = .white.withAlphaComponent(0.5)
        lbl.font = .systemFont(ofSize: 12)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let fallingAsleepValueLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "23:00"
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 20)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let fallingAsleepLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Falling asleep:"
        lbl.textColor = .white.withAlphaComponent(0.5)
        lbl.font = .systemFont(ofSize: 12)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let sunImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.image = UIImage(systemName: "sun.max.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let moonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.image = UIImage(systemName: "moon.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        // settings
        backgroundColor = .black.withAlphaComponent(0.6)
        layer.cornerRadius = 20
        translatesAutoresizingMaskIntoConstraints = false
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
    }

    //MARK: - Add subviews
    private func addSubviews() {
        addSubview(moonImageView)
        addSubview(sunImageView)
        addSubview(fallingAsleepLbl)
        addSubview(fallingAsleepValueLbl)
        addSubview(awakeningLbl)
        addSubview(awakeningValueLbl)
        addSubview(hoursLbl)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let moonImageViewConstraints = [
            moonImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            moonImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ]
        
        let sunImageViewConstraints = [
            sunImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            sunImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ]
        
        let fallingAsleepLblConstraints = [
            fallingAsleepLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            fallingAsleepLbl.topAnchor.constraint(equalTo: topAnchor, constant: 15)
        ]
        
        let fallingAsleepValueLblConstraints = [
            fallingAsleepValueLbl.centerXAnchor.constraint(equalTo: fallingAsleepLbl.centerXAnchor, constant: -6),
            fallingAsleepValueLbl.topAnchor.constraint(equalTo: fallingAsleepLbl.bottomAnchor, constant: 10)
        ]
        
        let awakeningLblConstraints = [
            awakeningLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            awakeningLbl.topAnchor.constraint(equalTo: fallingAsleepLbl.topAnchor)
        ]
        
        let awakeningValueLblConstraints = [
            awakeningValueLbl.centerXAnchor.constraint(equalTo: awakeningLbl.centerXAnchor, constant: -5),
            awakeningValueLbl.topAnchor.constraint(equalTo: awakeningLbl.bottomAnchor, constant: 10)
        ]
        
        let hoursLblConstraints = [
            hoursLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
            hoursLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ]
        
        NSLayoutConstraint.activate(moonImageViewConstraints)
        NSLayoutConstraint.activate(sunImageViewConstraints)
        NSLayoutConstraint.activate(fallingAsleepLblConstraints)
        NSLayoutConstraint.activate(fallingAsleepValueLblConstraints)
        NSLayoutConstraint.activate(awakeningLblConstraints)
        NSLayoutConstraint.activate(awakeningValueLblConstraints)
        NSLayoutConstraint.activate(hoursLblConstraints)
    }
    
    //MARK: - Configure
//    public func configure(asleep: String?, awake: String?, hours: String?) {
//
//    }
    public func configure(with model: SleepPhase?) {
        guard let awake = model?.awake, let asleep = model?.asleep, let hours = model?.hours else {
            awakeningValueLbl.text = "--:--"
            fallingAsleepValueLbl.text = "--:--"
            hoursLbl.text = "-"
            return
        }
        
        awakeningValueLbl.text = awake
        fallingAsleepValueLbl.text = asleep
        hoursLbl.text = hours
    }
    
    //MARK: - Required init
    required init?(coder: NSCoder) {
        fatalError()
    }
}
