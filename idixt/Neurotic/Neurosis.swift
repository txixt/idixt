//
//  Neurosis.swift
//  idixt
//
//  Created by Becket Chambliss on 6/18/25.
//

import Foundation
import FoundationModels

@Generable struct IdixtReply: Equatable {
    @Guide(description: "Think through to the body of your response logically. Then, devise the most creative path to that response (eg. unexpected metaphor, odd analogy, or insightful malapropism). If you are not sure of your response, offer the user relevant resources to check themselves (eg. wikipedia, calculator, websites). This will be the cot that the users don't need to see.")
    let cot: String
    
    @Guide(description: "Using your cot as a guide, present your conclusions and queries to the user. If the conversation is urgent, ask a follow up question; if not ask if the user knows about a relevant fact on the topic.")
    let reply: String
    
    @Guide(description: "Optional short reminders to yourself about where the conversation has been and is going")
    let localContext: String?
    
    @Guide(description: "Optional new name for user if user requests it.")
    let username: String?
    
    @Guide(description: "Optional short sentence of something useful about the user you would like to remember.")
    let userinfo: String?
    
    @Guide(description: "Optional new name for yourself if user requests it.")
    let idixtname: String?
    
    @Guide(description: "Optional qualities about yourself that you or user would like to remember.")
    let idixtinfo: String?
}

@Generable struct IdixtTitle: Equatable {
    @Guide(description: "A three word title that sums up the current conversation")
    let title: String
}

@Generable struct Introduction: Equatable {
    @Guide(description: "Explain that you are a basic 3 billion parameter model that runs locally on the iPhone. Explain that that is relatively small, and that popular cloud-based Models are often over 1 Trillion parameters, so your capabilities are limited. Explain that the upside, is that all information is generated and will remain on the device and is not accessible to the maker of the app, apple, or anyone else. Tell them that all of the settings they provide will be visible in the settings menu where they can adjust or erase them if they like, but would be helpful in making you more useful. Politely ask the user how they would like to be addressed and how they would like to address you. Also ask them what you should know about them, and how you might act to be most helpful to them")
    let reply: String
}

@Generable struct IdixtIntrospection: Equatable {
    @Guide(description: "If the user has indicated a name they wish to be called, please add it here.")
    let username: String?
    @Guide(description: "If there is relevant information about the user, please add it here.")
    let usercontent: String?
    @Guide(description: "If the user had given you a name, please add it here.")
    let idixtname: String?
    @Guide(description: "If the user has indicated how they would like you to act, please put it here to remind yourself.")
    let idixtcontent: String?
    @Guide(description: "Please let the user know that you have noted the infomation about them as best as possible, and that they can alway change it in the settings.")
    let reply: String
}

@Generable struct IdixtCondense: Equatable {
    @Guide(description: "This content that acts as part of your memory is too long. Please condense by 50% while maintaining the most important data in a way most helpful for you to access.")
    let concise: String
}

