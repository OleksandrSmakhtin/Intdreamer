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
        DatabaseManager.shared.fetchData().sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] interpretations in
            self?.interpretations = interpretations
        }.store(in: &subscriptions)        
    }
//
//
//    func addInterpretation() {
//        let model = InterpretationModel(description: "Based on your neutral morning feeling, it is possible that the emotions experienced in your dream were not particularly intense. This could suggest that the themes and events in your dream may not have had a significant impact on your overall mood upon waking. It is important to note that dreams can vary in emotional intensity and may not always directly correlate with our waking emotions. In analyzing the dream based on the artifacts you provided, it is difficult to pinpoint the exact interpretation without more specific details. However, it is possible that the dream signifies a sense of neutrality or contentment in your waking life, as opposed to an underlying stress or concern. It could be a reflection of a balanced and stable mindset, where your", date: "06.05.2023")
////        DatabaseManager.shared.addData(data: model).sink { [weak self] completion in
////            if case .failure(let error) = completion {
////                print(error.localizedDescription)
////                self?.error = error.localizedDescription
////            }
////        } receiveValue: { _ in
////            print("Added")
////        }.store(in: &subscriptions)
//        DatabaseManager.shared.addData(data: model)
//    }
    
    
}
