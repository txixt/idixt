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
    var content: String
    var faceidLock: Bool
    
    init(name: String = "unknown", content: String = "" ) {
        self.id = UUID().uuidString
        self.name = name
        self.content = content
        self.faceidLock = false
    }
}
