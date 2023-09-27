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
    @Published var lastDiary: Interpretation?
    @Published var isDailyBoxOpened = false
    @Published var isOnboarded = true
    
    @Published var error: String?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    // check onboarding
    func checkOnboarding() {
        let onboardingStatus = UserDefaults.standard.bool(forKey: "isOnboarded")
        isOnboarded = onboardingStatus
    }
    
    // check daily
    func checkDaily() {
        let currentDate = Date()
        if let lastViewedDate = UserDefaults.standard.object(forKey: "lastOpenedDailyBoxScreen") as? Date {
            let calendar = Calendar.current
            if let dayDifference = calendar.dateComponents([.day], from: lastViewedDate, to: currentDate).day, dayDifference >= 1 {
                isDailyBoxOpened = false
            } else {
                isDailyBoxOpened = true
            }
        } else {
            isDailyBoxOpened = true
        }
    }
    
    // get sleep phase
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
    
    // get last diary
    func getInterpretations() {
        DatabaseManager.shared.fetchInrepretationsData().sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] interpretations in
            self?.lastDiary = interpretations.last
        }.store(in: &subscriptions)
    }
    
}
