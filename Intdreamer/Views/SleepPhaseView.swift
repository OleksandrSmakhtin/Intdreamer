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
    private let hoursValueLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "9"
        lbl.textColor = .white
        lbl.font = UIFont(name: "Marker Felt", size: 30)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let hoursLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "hours"
        lbl.textColor = .white.withAlphaComponent(0.5)
        lbl.font = UIFont(name: "Optima", size: 14)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    private let hoursView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "tintColor")
        view.layer.cornerRadius = 50
        view.layer.borderWidth = 0.3
        view.layer.borderColor = UIColor.white.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let awakeningValueLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "07:00"
        lbl.textColor = .white
        lbl.font = UIFont(name: "Marker Felt", size: 18)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let awakeningLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Awakening:"
        lbl.textColor = .white.withAlphaComponent(0.5)
        lbl.font = UIFont(name: "Optima", size: 13)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let sunImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Sun")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let fallingAsleepValueLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "23:00"
        lbl.textColor = .white
        lbl.font = UIFont(name: "Marker Felt", size: 18)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let fallingAsleepLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Falling asleep:"
        lbl.textColor = .white.withAlphaComponent(0.5)
        lbl.font = UIFont(name: "Optima", size: 13)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let moonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Moon")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        // settings
        backgroundColor = UIColor(named: "tintColor")!.withAlphaComponent(0.7)
        translatesAutoresizingMaskIntoConstraints = false
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
    }

    //MARK: - Add subviews
    private func addSubviews() {
        addSubview(awakeningValueLbl)
        addSubview(moonImageView)
        addSubview(sunImageView)
        addSubview(fallingAsleepLbl)
        addSubview(fallingAsleepValueLbl)
        addSubview(awakeningLbl)
        addSubview(hoursView)
        hoursView.addSubview(hoursLbl)
        hoursView.addSubview(hoursValueLbl)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let fallingAsleepLblConstraints = [
            fallingAsleepLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            fallingAsleepLbl.topAnchor.constraint(equalTo: topAnchor, constant: 15)
        ]
        
        let fallingAsleepValueLblConstraints = [
            fallingAsleepValueLbl.leadingAnchor.constraint(equalTo: fallingAsleepLbl.leadingAnchor),
            fallingAsleepValueLbl.topAnchor.constraint(equalTo: fallingAsleepLbl.bottomAnchor, constant: 5)
        ]
        
        let moonImageViewConstraints = [
            moonImageView.leadingAnchor.constraint(equalTo: fallingAsleepValueLbl.leadingAnchor),
            moonImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            moonImageView.topAnchor.constraint(equalTo: fallingAsleepValueLbl.bottomAnchor, constant: 15),
            moonImageView.widthAnchor.constraint(equalToConstant: 50),
            moonImageView.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let awakeningLblConstraints = [
            awakeningLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            awakeningLbl.topAnchor.constraint(equalTo: fallingAsleepLbl.topAnchor)
        ]
        
        let awakeningValueLblConstraints = [
            awakeningValueLbl.trailingAnchor.constraint(equalTo: awakeningLbl.trailingAnchor),
            awakeningValueLbl.topAnchor.constraint(equalTo: awakeningLbl.bottomAnchor, constant: 5)
        ]
        
        let sunImageViewConstraints = [
            sunImageView.trailingAnchor.constraint(equalTo: awakeningValueLbl.trailingAnchor),
            sunImageView.bottomAnchor.constraint(equalTo: moonImageView.bottomAnchor),
            sunImageView.topAnchor.constraint(equalTo: awakeningValueLbl.bottomAnchor, constant: 15),
            sunImageView.widthAnchor.constraint(equalToConstant: 50),
            sunImageView.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let hoursViewConstraints = [
            hoursView.centerXAnchor.constraint(equalTo: centerXAnchor),
            hoursView.centerYAnchor.constraint(equalTo: bottomAnchor),
            hoursView.heightAnchor.constraint(equalToConstant: 100),
            hoursView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let hoursLblConstraints = [
            hoursLbl.centerXAnchor.constraint(equalTo: hoursView.centerXAnchor),
            hoursLbl.bottomAnchor.constraint(equalTo: hoursView.bottomAnchor, constant: -20)
        ]
        
        let hoursValueLblConstraints = [
            hoursValueLbl.centerXAnchor.constraint(equalTo: hoursView.centerXAnchor),
            hoursValueLbl.centerYAnchor.constraint(equalTo: hoursView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(fallingAsleepLblConstraints)
        NSLayoutConstraint.activate(fallingAsleepValueLblConstraints)
        NSLayoutConstraint.activate(moonImageViewConstraints)
        NSLayoutConstraint.activate(awakeningLblConstraints)
        NSLayoutConstraint.activate(awakeningValueLblConstraints)
        NSLayoutConstraint.activate(sunImageViewConstraints)
        NSLayoutConstraint.activate(hoursViewConstraints)
        NSLayoutConstraint.activate(hoursLblConstraints)
        NSLayoutConstraint.activate(hoursValueLblConstraints)
    }
    
    //MARK: - Configure
//    public func configure(asleep: String?, awake: String?, hours: String?) {
//
//    }
    public func configure(with model: SleepPhase?) {
        guard let awake = model?.awake, let asleep = model?.asleep, let hours = model?.hours else {
            awakeningValueLbl.text = "--:--"
            fallingAsleepValueLbl.text = "--:--"
            hoursValueLbl.text = "-"
            return
        }
        
        awakeningValueLbl.text = awake
        fallingAsleepValueLbl.text = asleep
        hoursValueLbl.text = hours
    }
    
    //MARK: - Required init
    required init?(coder: NSCoder) {
        fatalError()
    }
}
