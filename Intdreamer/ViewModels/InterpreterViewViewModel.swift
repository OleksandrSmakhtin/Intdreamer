//
//  InterpreterViewViewModel.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 11/09/2023.
//

import Foundation
import Combine


final class InterpreterViewViewModel: ObservableObject {
    
    var answers: [String] = []
    var currentAnswer: String = ""
    
    @Published var question: Question?
    @Published var isOptionSelected = false
    @Published var index = 0
    @Published var isSaved = false
    
    @Published var error: String?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    // save to diary
    func saveToDiary() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let model = InterpretationModel(description: getFullMessage(), date: dateFormatter.string(from: date))
        
        DatabaseManager.shared.saveInrepretationsData(data: model).sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] state in
            self?.isSaved = state
        }.store(in: &subscriptions)
    }
    
    // get full message
    func getFullMessage() -> String {
        return answers.joined(separator: " \n\n ")
    }
    
    // transit answers
    func transitAnswers() -> [String] {
        answers.append(currentAnswer)
        return answers
    }
    
    // set answer
    func setAnswer(answer: String) {
        currentAnswer = answer
    }
    
    // get question
    func getQuestion() -> Question {
        return Questions.shared.getQuestion(for: index)
    }
}
