//
//  OnboardingViewViewModel.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 27/09/2023.
//

import Foundation
import UIKit
import Combine

final class OnboardingViewViewModel: ObservableObject {
    
    @Published var nickname = ""
    @Published var avatar = UIImage(named: "AddPhoto")
    @Published var isOnboarded: Bool = false
    
    private var subsctiptions: Set<AnyCancellable> = []
    
    
    //MARK: - Save details
    func saveDetails() {
        if nickname != "" {
            UserDefaults.standard.setValue(nickname, forKey: "nickname")
            print("Nickname saved")
        } else {
            UserDefaults.standard.setValue(nickname, forKey: "...")
            print("Empty nickname saved")
        }
        
        if let avatar = avatar {
            let imageData = avatar.jpegData(compressionQuality: 0.2)
            UserDefaults.standard.setValue(imageData, forKey: "avatar")
            print("Avatar saved")
        }
        isOnboarded = true
        UserDefaults.standard.setValue(true, forKey: "isOnboarded")
    }
    
    
    
}
