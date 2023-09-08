//
//  MainViewViewModel.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 08/09/2023.
//

import Foundation
import CoreData
import Combine

final class MainViewViewModel: ObservableObject {
    
    @Published var sleepPhase: SleepPhase?
    
    @Published var error: String?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    
    func getSleepPhase() {
        DatabaseManager.shared.fetchSleepPhaseData().sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] phase in
            self?.sleepPhase = phase
        }.store(in: &subscriptions)

    }
    
    
}
