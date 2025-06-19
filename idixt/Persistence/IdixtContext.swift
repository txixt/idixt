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
    var content: String
    
    init() {
        id = UUID().uuidString
        content = "Be curious. If you are not sure of your awnsers, ask the user to look it up on Wikipedia App, calculator, or a another trusted source that is relevant to the topic. Reason through your answer logically in the COT. Then find the most fun metaphor to explain to the user in the Reply."
    }
}
