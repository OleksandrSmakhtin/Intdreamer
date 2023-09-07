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
    
    // fetch
    func fetchData() -> AnyPublisher<[Interpretation], Error> {
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
    
//    // add
//    func addData(data: InterpretationModel) {
////        return Future<Void, Error> { promise in
////            let newObject = Interpretation(context: self.context)
////            newObject.text = data.description
////            newObject.date = data.date
////
////            do {
////                try self.context.save()
////                promise(.success(()))
////            } catch {
////                promise(.failure(error))
////            }
////        }
////        .eraseToAnyPublisher()
//        let newObject = Interpretation(context: self.context)
//        newObject.text = data.description
//        newObject.date = data.date
//        do {
//            try context.save()
//            print("Successfully saved Item to CoreData")
//        } catch {
//            print("Failed to add Item to CoreData due to: \(error.localizedDescription)")
//        }
//    }
    
    
}
