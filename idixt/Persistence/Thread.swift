//
//  Thread.swift
//  idixt
//
//  Created by Becket on 6/18/25.
//

import Foundation
import SwiftData

@Model final class Thread {
    var id: String
    var title: String
    var exchange: [String]
    var localContext: String
    
    init(title: String = "New Thread", exchange: [String] = []) {
        self.id = UUID().uuidString
        self.title = title
        self.exchange = exchange
        self.localContext = ""
    }
}
