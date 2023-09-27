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
            // title
            let titleLbl: UILabel = {
                let lbl = UILabel()
                lbl.text = "Diary"
                lbl.textColor = UIColor(named: "tintColor")
                lbl.font = UIFont(name: "Marker Felt", size: 30)
                return lbl
            }()
            self?.navigationItem.titleView = titleLbl
            if interpretations.isEmpty {
                titleLbl.text = "Diary is empty"
            } else {
                titleLbl.text = "Diary"
            }
            DispatchQueue.main.async {
                self?.diaryTable.reloadData()
            }
        }.store(in: &subscriptions)
    }
    
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(backgroundImageView)
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
        
        let diaryTableConstraints = [
            diaryTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            diaryTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            diaryTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            diaryTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(backgroundImageViewConstraints)
        NSLayoutConstraint.activate(diaryTableConstraints)
    }
    
    //MARK: - Configure nav bar
    private func configureNavBar() {
        // title
        let titleLbl: UILabel = {
            let lbl = UILabel()
            lbl.text = "Diary"
            lbl.textColor = UIColor(named: "tintColor")
            lbl.font = UIFont(name: "Marker Felt", size: 40)
            return lbl
        }()
        navigationItem.titleView = titleLbl
        
        // right btn
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "HowToUse"), style: .plain, target: self, action: #selector(didPressInfoBtn))
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
        let model = viewModel.interpretations.reversed()[indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
    
}
