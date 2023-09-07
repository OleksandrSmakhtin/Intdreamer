//
//  DiaryVC.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 07/09/2023.
//

import UIKit
import Combine
import CoreData

class DiaryVC: UIViewController {
    
    //MARK: - viewModel
    private var viewModel = DiaryViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []

    //MARK: - UI Objects
    private let diaryTable: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.register(DiaryTableCell.self, forCellReuseIdentifier: DiaryTableCell.Identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let diaryLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Diary"
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
    @objc private func didPressInfoBtn() {
        let vc  = InfoVC()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.pushViewController(vc, animated: true)
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
        // delegates
        applyTableDelegate()
        // bind
        bindViews()
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // fetch data
        viewModel.getInterpretations()
    }
    
    //MARK: - Bind views
    private func bindViews() {
        viewModel.$interpretations.sink { [weak self] interpretations in
            DispatchQueue.main.async {
                self?.diaryTable.reloadData()
            }
        }.store(in: &subscriptions)
    }
    
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(diaryLbl)
        view.addSubview(diaryTable)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let backgroundImageViewConstraints = [
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor)
        ]
        
        let diaryLblConstraints = [
            diaryLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            diaryLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        ]
        
        let diaryTableConstraints = [
            diaryTable.topAnchor.constraint(equalTo: diaryLbl.bottomAnchor, constant: 30),
            diaryTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            diaryTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            diaryTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(backgroundImageViewConstraints)
        NSLayoutConstraint.activate(diaryLblConstraints)
        NSLayoutConstraint.activate(diaryTableConstraints)
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


//MARK: - UITableViewDelegate & DataSource
extension DiaryVC: UITableViewDelegate, UITableViewDataSource {
    // table delegate
    private func applyTableDelegate() {
        diaryTable.delegate = self
        diaryTable.dataSource = self
    }
    
    // number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.interpretations.count
    }
    
    // cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiaryTableCell.Identifier) as? DiaryTableCell else { return UITableViewCell()}
        let model = viewModel.interpretations[indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
    
}
