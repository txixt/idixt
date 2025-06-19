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
    var username: String
    var userContext: String
    var faceidLock: Bool 
    
    init(username: String = "unknown", userContext: String = "" ) {
        self.id = UUID().uuidString
        self.username = username
        self.userContext = userContext
        self.faceidLock = false
    }
}
