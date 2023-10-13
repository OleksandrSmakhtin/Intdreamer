//
//  ProfileViewViewModel.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 28/09/2023.
//

import Foundation
import Combine
import UIKit

final class ProfileViewViewModel: ObservableObject {
    
    @Published var nickname = ""
    @Published var avatar: UIImage?
    
    
    func saveData() {
        UserDefaults.standard.setValue(nickname, forKey: "nickname")
        if let avatar = avatar {
            let imageData = avatar.jpegData(compressionQuality: 0.2)
            UserDefaults.standard.setValue(imageData, forKey: "avatar")
            print("Avatar saved")
        }
    }
}
