//
//  DatabaseManager.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 07/09/2023.
//

import Foundation
import CoreData
import UIKit
import Combine

class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    //MARK: - Interpretations
    // fetch
    func fetchInrepretationsData() -> AnyPublisher<[Interpretation], Error> {
        return Future<[Interpretation], Error> { promise in
            let request = Interpretation.fetchRequest()
            do {
                let results = try self.context.fetch(request)
                promise(.success(results))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    // add
    func addData(data: InterpretationModel) {
//        return Future<Void, Error> { promise in
//            let newObject = Interpretation(context: self.context)
//            newObject.text = data.description
//            newObject.date = data.date
//
//            do {
//                try self.context.save()
//                promise(.success(()))
//            } catch {
//                promise(.failure(error))
//            }
//        }
//        .eraseToAnyPublisher()
        let newObject = Interpretation(context: self.context)
        newObject.text = data.description
        newObject.date = data.date
        do {
            try context.save()
            print("Successfully saved Item to CoreData")
        } catch {
            print("Failed to add Item to CoreData due to: \(error.localizedDescription)")
        }
    }
    
    //MARK: - Sleep Phase
    // fetch
    func fetchSleepPhaseData() -> AnyPublisher<SleepPhase, Error> {
        return Future<SleepPhase, Error> { promise in
            let request = SleepPhase.fetchRequest()
            do {
                let results = try self.context.fetch(request)
                if let result = results.first {
                    promise(.success(result))
                }
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    // save
    func saveSleepPhaseData(awake: String, asleep: String, hours: String) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            let request = SleepPhase.fetchRequest()
            do {
                let results = try self.context.fetch(request)
                
                if let result = results.first {
                    result.awake = awake
                    result.asleep = asleep
                    result.hours = hours
                    try self.context.save()
                } else {
                    let sleepPhase = SleepPhase(context: self.context)
                    sleepPhase.awake = awake
                    sleepPhase.asleep = asleep
                    sleepPhase.hours = hours
                    try self.context.save()
                }
                print("Sleep Phase Saved")
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
}
