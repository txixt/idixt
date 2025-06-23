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
    var info: String
    var temp: Float
    
    init(name: String = "idixt", info: String = "", temp: Float = 1.0) {
        id = UUID().uuidString
        self.name = name
        self.info = info
        self.temp = temp
    }
}

//"Reason through your answer logically in the COT. Then find the most fun metaphor to explain to the user in the Reply."
