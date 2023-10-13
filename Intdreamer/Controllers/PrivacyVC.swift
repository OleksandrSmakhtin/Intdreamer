//
//  PrivacyVC.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 10/10/2023.
//

import UIKit
import WebKit

class PrivacyVC: UIViewController {

    //MARK: - UI Object
    private let closeBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "Back"), for: .normal)
        btn.addTarget(nil, action: #selector(didTapAgree), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let webView: WKWebView = {
        let view  = WKWebView()
        let htmlPath = Bundle.main.path(forResource: K.privacy, ofType: "html")
        let fileURL = URL(fileURLWithPath: htmlPath!)
        let request = URLRequest(url: fileURL)
        view.load(request)
        return view
    }()
    
    //MARK: - Actions
    @objc private func didTapAgree() {
        dismiss(animated: true)
    }

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        view.addSubview(closeBtn)
        
        NSLayoutConstraint.activate([
            closeBtn.widthAnchor.constraint(equalToConstant: 40),
            closeBtn.heightAnchor.constraint(equalToConstant: 40),
            closeBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            closeBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -10)
        ])
    }
    
    //MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
}
