//
//  OnboardingVC.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 14/09/2023.
//

import UIKit
import Combine
import AVFoundation

class OnboardingVC: UIViewController {
    
    //MARK: - viewModel
    private var viewModel = OnboardingViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []

    //MARK: - UI Objects
    private let addPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white.withAlphaComponent(0.2)
        textField.layer.borderWidth = 3
        textField.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 50))
        textField.leftViewMode = .always
        textField.font = UIFont(name: "Marker Felt", size: 18)
        textField.textColor = .white
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "Marker Felt", size: 18) as Any
        ]
        textField.autocorrectionType = .no
        textField.attributedPlaceholder = NSAttributedString(string: "Nick name", attributes: attributes)
        textField.tintColor = .white
        textField.addTarget(nil, action: #selector(didChangeTextField), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let onboardingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "tintColor")?.withAlphaComponent(0.5)
        view.layer.borderWidth = 0.3
        view.layer.borderColor = UIColor.white.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let continueBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "Continue"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(nil, action: #selector(didPressContinue), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bg")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Actions
    @objc private func didPressOnAvatar() {
        chooseAvatar()
    }
    
    @objc private func didPressContinue() {
        viewModel.saveDetails()
    }
    
    @objc private func didChangeTextField() {
        guard let text = nameField.text else { return }
        viewModel.nickname = text
    }
    
    @objc private func dissmissAction() {
        view.endEditing(true)
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
        // bind views
        bindViews()
    }
    
    //MARK: - Bind Views
    private func bindViews() {
        // avatar
        viewModel.$avatar.sink { [weak self] avatar in
            guard let avatar = avatar else { return }
            self?.addPhotoImageView.image = avatar
        }.store(in: &subscriptions)
        
        // is onboarded
        viewModel.$isOnboarded.sink { [weak self] status in
            if status {
                self?.navigationController?.popViewController(animated: true)
            }
        }.store(in: &subscriptions)
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dissmissAction)))
        view.addSubview(onboardingView)
        view.addSubview(nameField)
        view.addSubview(addPhotoImageView)
        addPhotoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didPressOnAvatar)))
        view.addSubview(continueBtn)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let backgroundImageViewConstraints = [
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor)
        ]
        
        let onboardingViewConstraints = [
            onboardingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            onboardingView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            onboardingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 130),
            onboardingView.heightAnchor.constraint(equalToConstant: 280)
        ]
        
        let nameFieldConstraints = [
            nameField.leadingAnchor.constraint(equalTo: onboardingView.leadingAnchor, constant: 30),
            nameField.trailingAnchor.constraint(equalTo: onboardingView.trailingAnchor, constant: -30),
            nameField.bottomAnchor.constraint(equalTo: onboardingView.bottomAnchor, constant: -40),
            nameField.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let addPhotoImageViewConstraints = [
            addPhotoImageView.topAnchor.constraint(equalTo: onboardingView.topAnchor, constant: 30),
            addPhotoImageView.centerXAnchor.constraint(equalTo: onboardingView.centerXAnchor),
            addPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            addPhotoImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let continueBtnConstraints = [
            continueBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueBtn.topAnchor.constraint(equalTo: onboardingView.bottomAnchor, constant: 20)
        ]
        
        NSLayoutConstraint.activate(backgroundImageViewConstraints)
        NSLayoutConstraint.activate(onboardingViewConstraints)
        NSLayoutConstraint.activate(nameFieldConstraints)
        NSLayoutConstraint.activate(addPhotoImageViewConstraints)
        NSLayoutConstraint.activate(continueBtnConstraints)
    }
    
    
    //MARK: - Choose avatar
    private func chooseAvatar() {
        // picker
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        // alert
        let alert = UIAlertController(title: "Choose source", message: nil, preferredStyle: .actionSheet)
        // camera action
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
            AVCaptureDevice.requestAccess(for: .video) { isAllowed in
                if isAllowed {
                    DispatchQueue.main.async {
                        imagePicker.sourceType = .camera
                        imagePicker.allowsEditing = true
                        self?.present(imagePicker, animated: true, completion: nil)
                    }
                }
            }
        }
        
        // gallery action
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { [weak self] _ in
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            self?.present(imagePicker, animated: true)
        }
        
        // cancel
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // request
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        
        let popOver = alert.popoverPresentationController
        popOver?.sourceView = self.view
        popOver?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.minY, width: 0, height: 0)
        popOver?.permittedArrowDirections = .any
        
        self.present(alert, animated: true)
    }
    
    //MARK: - Check camera
    private func isCameraAuthorized() -> Bool{
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            return true
        case .notDetermined:
            return false
        case .denied, .restricted:
            return false
        default:
            return false
        }
    }
    
    private func requestCameraAuthorization() {
        AVCaptureDevice.requestAccess(for: .video) { _ in }
    }

    //MARK: - Configure nav bar
    private func configureNavBar() {
        // title
        let titleLbl: UILabel = {
            let lbl = UILabel()
            lbl.text = "Account"
            lbl.textColor = UIColor(named: "tintColor")
            lbl.font = UIFont(name: "Marker Felt", size: 40)
            return lbl
        }()
        navigationItem.titleView = titleLbl
        navigationItem.hidesBackButton = true
    }
}



//MARK: - PHPickerViewControllerDelegate
extension OnboardingVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // did finish picking
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            viewModel.avatar = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }

    // did cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
