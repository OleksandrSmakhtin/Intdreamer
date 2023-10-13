//
//  ProfileVC.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 27/09/2023.
//

import UIKit
import AVFoundation
import PhotosUI
import Combine

class ProfileVC: UIViewController {

    //MARK: - viewModel
    private var viewModel = ProfileViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []

    //MARK: - UI Objects
    private let profileView = ProfileView()
    
    private let saveBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "Save"), for: .normal)
        btn.layer.opacity = 0.0
        btn.addTarget(nil, action: #selector(didPressSaveBtn), for: .touchUpInside)
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
    @objc private func didPressSaveBtn() {
        viewModel.saveData()
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didPressInfoBtn() {
        let vc  = InfoVC()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.pushViewController(vc, animated: true)
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
        // apply delegates
        applyProfileViewDelegate()
    }
    
    //MARK: - Bind views
    private func bindViews() {
        // name
        viewModel.$nickname.sink { [weak self] name in
            if name.count > 3 {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) { [weak self] in
                    self?.saveBtn.layer.opacity = 1.0
                } completion: { _ in }
            } else {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) { [weak self] in
                    self?.saveBtn.layer.opacity = 0.0
                } completion: { _ in }
            }
        }.store(in: &subscriptions)
        
        // avatar
        viewModel.$avatar.sink { [weak self] image in
            guard let image = image else { return }
            self?.profileView.changeImage(on: image)
        }.store(in: &subscriptions)
    }
    
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dissmissAction)))
        view.addSubview(profileView)
        view.addSubview(saveBtn)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let backgroundImageViewConstraints = [
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor)
        ]
        
        let profileViewConstraints = [
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
        ]
        
        let saveBtnConstraints = [
            saveBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            saveBtn.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(backgroundImageViewConstraints)
        NSLayoutConstraint.activate(profileViewConstraints)
        NSLayoutConstraint.activate(saveBtnConstraints)
    }
    
    //MARK: - Configure nav bar
    private func configureNavBar() {
        // title
        let titleLbl: UILabel = {
            let lbl = UILabel()
            lbl.text = "Profile"
            lbl.textColor = UIColor(named: "tintColor")
            lbl.font = UIFont(name: "Marker Felt", size: 40)
            return lbl
        }()
        navigationItem.titleView = titleLbl
        
        // right btn
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "HowToUse"), style: .plain, target: self, action: #selector(didPressInfoBtn))
    }
}




//MARK: - ProfileViewDelegate
extension ProfileVC: ProfileViewDelegate {
    // apply delegate
    private func applyProfileViewDelegate() {
        profileView.delegate = self
    }
    // privacy
    func didSelectPrivacy() {
        let vc = PrivacyVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    // name
    func didChangeTextField(text: String) {
        viewModel.nickname = text
    }
    
    // avatar
    func didTapOnAvatar() {
        // picker
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        // alert
        let alert = UIAlertController(title: "Choose source", message: nil, preferredStyle: .actionSheet)
        // camera action
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            self?.present(imagePicker, animated: true, completion: nil)
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
        if isCameraAuthorized() {
            alert.addAction(cameraAction)
        }
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
}

//MARK: - PHPickerViewControllerDelegate
extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // did finish picking
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            viewModel.avatar = pickedImage
            if profileView.getNicknameCount() > 3 {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) { [weak self] in
                    self?.saveBtn.layer.opacity = 1.0
                } completion: { _ in }
            }
            
        }
        picker.dismiss(animated: true, completion: nil)
    }

    // did cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
