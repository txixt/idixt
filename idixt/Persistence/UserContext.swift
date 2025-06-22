//
//  UserContext.swift
//  idixt
//
//  Created by Becket on 6/18/25.
//

import Foundation
import SwiftData

@Model final class UserContext {
    var id: String
    var name: String
    var info: String
    var faceidLock: Bool
    
    init(name: String = "unknown", info: String = "" ) {
        self.id = UUID().uuidString
        self.name = name
        self.info = info
        self.faceidLock = false
    }
}
