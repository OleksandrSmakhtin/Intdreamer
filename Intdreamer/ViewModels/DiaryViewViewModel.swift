//
//  DiaryViewViewModel.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 07/09/2023.
//

import Foundation
import Combine
import CoreData

final class DiaryViewViewModel: ObservableObject {
    
    
    @Published var interpretations: [Interpretation] = []
    @Published var error: String?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    
    //MARK: - Fetch
    func getInterpretations() {
        DatabaseManager.shared.fetchInrepretationsData().sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] interpretations in
            self?.interpretations = interpretations
        }.store(in: &subscriptions)        
    }
}
