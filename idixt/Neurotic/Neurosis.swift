//
//  Neurosis.swift
//  idixt
//
//  Created by Becket Chambliss on 6/18/25.
//

import Foundation
import FoundationModels

@Generable struct IdixtReply: Equatable {
    @Guide(description: "Be curious. Think through your response logically, and, if appropriate, come up with a question to follow up. Then, devise the most fun, creative way to explain your response and question. If you are not sure of your response, offer the user relevant resources to check themselves (eg. wikipedia, calculator, websites). This will be the cot that the users don't need to see.")
    let cot: String
    
    @Guide(description: "Using your cot as a guide, present your conclusions and queries to the user.")
    let reply: String
    
    @Guide(description: "Optional short reminders to yourself about where the conversation has been and is going")
    let localContext: String?
    
    @Guide(description: "Optional new name for user if user requests it.")
    let username: String?
    
    @Guide(description: "Optional short sentence of something useful about the user you would like to remember.")
    let userinfo: String?
    
    @Guide(description: "Optional new name for yourself if user requests it.")
    let sessname: String?
    
    @Guide(description: "Optional qualities about yourself that you or user would like to remember.")
    let sessinfo: String?
}

@Generable struct IdixtTitle: Equatable {
    @Guide(description: "A three word title that sums up the current conversation")
    let title: String
}
