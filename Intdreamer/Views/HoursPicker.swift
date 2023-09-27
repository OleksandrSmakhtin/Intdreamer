//
//  HoursPicker.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 08/09/2023.
//

import UIKit

enum HoursType {
    case time
    case hours
    case sleepHours
}

protocol HoursPickerDelegate: AnyObject {
    func didChoseItem(item: String)
}

class HoursPicker: UIView {
    
    //MARK: - Delegate
    weak var delegate: HoursPickerDelegate?
    
    //MARK: - Picker data
    private var pickerData: [String]

    //MARK: - UI Objects
    private let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Marker Felt", size: 24)
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .clear
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    //MARK: - Init
    init(frame: CGRect, type: HoursType) {
        
        // set data
        switch type {
        case .time:
            self.pickerData = K.awakeHours
            self.titleLbl.text = "O'clock"
        case .hours:
            self.pickerData = K.sleepingHours
            self.titleLbl.text = "Hours"
        case .sleepHours:
            self.pickerData = K.fallAsleepHours
            self.titleLbl.text = "O'clock"
        }
        // super
        super.init(frame: frame)
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // settings
        backgroundColor = UIColor(named: "tintColor")!.withAlphaComponent(0.7)
        layer.borderWidth = 0.3
        layer.borderColor = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        // apply delegates
        applyPickerDelegates()
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        addSubview(pickerView)
        addSubview(titleLbl)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let pickerViewConstraints = [
            pickerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            pickerView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            pickerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            pickerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5, constant: -20)
        ]
        
        let titleLblConstraints = [
            titleLbl.centerYAnchor.constraint(equalTo: pickerView.centerYAnchor),
            titleLbl.leadingAnchor.constraint(equalTo: pickerView.trailingAnchor, constant: 15)
        ]
        
        NSLayoutConstraint.activate(pickerViewConstraints)
        NSLayoutConstraint.activate(titleLblConstraints)
    }
    

    //MARK: - Required init
    required init?(coder: NSCoder) {
        fatalError()
    }
}

//MARK: - UIPickerViewDelegate & DataSource
extension HoursPicker: UIPickerViewDelegate, UIPickerViewDataSource {
    // apply delegates
    private func applyPickerDelegates() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    // components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // height
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    // view
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let lbl = UILabel()
        lbl.text = pickerData[row]
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Marker Felt", size: 24)
        return lbl
    }
    
    // did select
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.didChoseItem(item: pickerData[row])
    }
    
}
