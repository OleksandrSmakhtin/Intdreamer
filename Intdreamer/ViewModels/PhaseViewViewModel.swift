//
//  PhaseViewViewModel.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 07/09/2023.
//

import Foundation
import Combine

final class PhaseViewViewModel: ObservableObject {
    
    var awakeTime = "05:00"
    var sleepHours = "5"
    
    @Published var currentStage: CalculationStages = .description
    @Published var lastStage: CalculationStages = .description
    
    @Published var error: String?
    
    private var subscriptions: Set<AnyCancellable> = []
    

    // calculate phase
    func calculatePhase() {
        guard let sleepFloat = Float(sleepHours) else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        guard let awakeDate = dateFormatter.date(from: awakeTime) else { return }
        let minutesOfSleep = Int(sleepFloat * 60)
        
        guard let asleepTime = Calendar.current.date(byAdding: .minute, value: -minutesOfSleep, to: awakeDate) else { return }
        let bedTime = dateFormatter.string(from: asleepTime)
        print(bedTime)
        saveSleepPhase(awake: awakeTime, asleep: bedTime, hours: sleepHours)
    }
    
    
    // switch stage
    func switchStage() {
        switch lastStage {
        case .description:
            currentStage = .wake
            lastStage = .description
        case .wake:
            currentStage = .hours
            lastStage = .wake
        case .hours:
            currentStage = .sleep
            lastStage = .hours
        case .sleep:
            return
        }
    }
    
    // save phase
    private func saveSleepPhase(awake: String, asleep: String, hours: String) {
        DatabaseManager.shared.saveSleepPhaseData(awake: awake, asleep: asleep, hours: hours).sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { _ in
            print("Saved")
        }.store(in: &subscriptions)
    }
}


