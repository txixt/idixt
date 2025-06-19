//
//  IdixtManager.swift
//  idixt
//
//  Created by Becket on 6/19/25.
//

import Foundation

struct IdixtManager {
    static func introduce(idiot: IdixtModel?, gov: Governor) async throws {
        guard let idiot else { print("error loading model"); return }
        do {
            try await idiot.generateIntroduce()
        } 
    }
    
    static func compress(idiot: IdixtModel?) {
        
    }
}
