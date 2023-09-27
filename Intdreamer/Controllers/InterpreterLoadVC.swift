//
//  InterpreterLoadVC.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 11/09/2023.
//

import UIKit
import Combine

class InterpreterLoadVC: UIViewController {
    
    //MARK: - Timer
    private var timer: Timer?
    private var timerCounter = 0.0
    
    //MARK: - View Model
    var viewModel = InterpreterViewViewModel()

    //MARK: - UI Objects
    private let continueBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "Continue"), for: .normal)
        btn.layer.opacity = 0
        btn.addTarget(nil, action: #selector(didPressContinueBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let dots: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.preferredIndicatorImage = UIImage(named: "Indicator")
        pageControl.preferredCurrentPageIndicatorImage = UIImage(named: "CurrentIndicator")
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private let bottomLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Your input will assist Zeus, our Dream Interpreter, in crafting a tailored dream analysis rooted in your sleep patterns and experiences."
        lbl.textColor = UIColor(named: "tintColor")
        lbl.font = UIFont(name: "Optima", size: 18)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let loadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Load")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let topLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Thank you for participating in our dream experience and sleep quality survey!"
        lbl.textColor = UIColor(named: "tintColor")
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
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
    @objc private func didPressContinueBtn() {
        let vc  = DescriptionVC()
        vc.viewModel.answers = viewModel.transitAnswers()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func autoChangeDot() {
        let nextPage = (dots.currentPage + 1) % 4
        dots.currentPage = nextPage
        timerCounter += 0.1
        if timerCounter >= 3 {
            timer?.invalidate()
            dots.isHidden = true
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut) { [weak self] in
                self?.continueBtn.layer.opacity = 1
            } completion: { _ in }
        }
    }
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // configure nav bar
        configureNavBar()
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // set timer
        setTimer()
    }

    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(topLbl)
        view.addSubview(continueBtn)
        view.addSubview(dots)
        view.addSubview(bottomLbl)
        view.addSubview(loadImageView)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let backgroundImageViewConstraints = [
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor)
        ]
        
        let topLblConstraints = [
            topLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            topLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            topLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80)
        ]
        
        let continueBtnConstraints = [
            continueBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            continueBtn.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let dotsConstraints = [
            dots.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dots.centerYAnchor.constraint(equalTo: continueBtn.centerYAnchor),
            dots.heightAnchor.constraint(equalToConstant: 10)
        ]
        
        let bottomLblConstraints = [
            bottomLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bottomLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bottomLbl.bottomAnchor.constraint(equalTo: continueBtn.topAnchor, constant: -40)
        ]
        
        let loadImageViewConstraints = [
            loadImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadImageView.topAnchor.constraint(equalTo: topLbl.bottomAnchor, constant: 30),
            loadImageView.bottomAnchor.constraint(equalTo: bottomLbl.topAnchor, constant: -30)
        ]
        
        NSLayoutConstraint.activate(backgroundImageViewConstraints)
        NSLayoutConstraint.activate(topLblConstraints)
        NSLayoutConstraint.activate(continueBtnConstraints)
        NSLayoutConstraint.activate(dotsConstraints)
        NSLayoutConstraint.activate(bottomLblConstraints)
        NSLayoutConstraint.activate(loadImageViewConstraints)
    }
    
    //MARK: - Set timer
    private func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(autoChangeDot), userInfo: nil, repeats: true)
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
        navigationItem.hidesBackButton = true
    }
}
