//
//  IdixtContext.swift
//  idixt
//
//  Created by Becket on 6/18/25.
//

import Foundation
import SwiftData

@Model final class IdixtContext {
    var id: String
    var name: String
    var content: String
    
    init(name: String = "idixt", content: String = "") {
        id = UUID().uuidString
        self.name = name
        self.content = content
    }
}

//"Reason through your answer logically in the COT. Then find the most fun metaphor to explain to the user in the Reply."
