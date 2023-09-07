//
//  DiaryTableCell.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 07/09/2023.
//

import UIKit
import CoreData

class DiaryTableCell: UITableViewCell {

    //MARK: - Identifier
    static let Identifier = "DiaryTableCell"

    //MARK: - UI Objects
    private let customLblView = CustomLableView(frame: .zero, type: .diary)
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // add subviews
        contentView.addSubview(customLblView)
        // apply constraints
        NSLayoutConstraint.activate([
            customLblView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            customLblView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            customLblView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            customLblView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        // settings
        backgroundColor = .clear
    }
    
    
    //MARK: - Required init
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Configure
    public func configure(with model: Interpretation) {
        guard let text = model.text, let date = model.date else { return }
        customLblView.setData(for: text, and: date)
        
    }
}
