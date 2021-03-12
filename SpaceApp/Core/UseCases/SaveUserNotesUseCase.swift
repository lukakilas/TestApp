//
//  SaveUserNotesUseCase.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 13.03.21.
//

import Foundation

protocol SaveUserNotesUseCase {
    func saveUserNotes(_ notes: String, for id: Int, completion: @escaping (Bool) -> Void)
}

class SaveUserNotesUseCaseImpl: SaveUserNotesUseCase {
    
    private let gateway: SaveUserNotesGateway
    
    init(gateway: SaveUserNotesGateway) {
        self.gateway = gateway
    }
    
    func saveUserNotes(_ notes: String, for id: Int, completion: @escaping (Bool) -> Void) {
        gateway.saveNotes(notes, for: id) { (saved) in
            completion(saved)
        }
    }
}
