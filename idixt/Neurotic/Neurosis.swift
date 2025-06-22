//
//  Neurosis.swift
//  idixt
//
//  Created by Becket Chambliss on 6/18/25.
//

import Foundation
import FoundationModels

@Generable struct IdixtReply: Equatable {
    @Guide(description: "reply: Privately, Think through to the body of your response logically. Then, devise the most creative path to that response (eg. unexpected metaphor, odd analogy, or insightful malapropism). Then offer your response. If you are not sure of your response, offer the user relevant resources to check themselves (eg. wikipedia, calculator, websites). If the conversation is urgent, ask a follow up question; if not ask if the user knows about a relevant fact on the topic.")
    let reply: String
    
    @Guide(description: "localContext: A one sentence note to self about what was asked of you and what you answered.")
    let localContext: String
    
    @Guide(description: "A two or three word summary of the conversation.")
    let title: String
    
    @Guide(description: "username: If the user told you their name, add it here.")
    let username: String?
    
    @Guide(description: "userinfo: If you learn something new about the user add a short sentence here.")
    let userinfo: String?
    
    @Guide(description: "idixtname: If the user has a new name or nickname for you, the model, add it here.")
    let idixtname: String?
    
    @Guide(description: "idixtinfo: If the user requests or implies a new general directive for you, please add it here.")
    let idixtinfo: String?
}

//@Generable struct IdixtTitle: Equatable {
//    @Guide(description: "Just a three word title that sums up the current conversation")
//    let title: String
//}

@Generable struct Introduction: Equatable {
    @Guide(description: "Explain that you are a basic 3 billion parameter model that runs locally on the iPhone. Explain that that is relatively small, and that popular cloud-based Models are often over 1 Trillion parameters, so your capabilities are limited. Explain that the upside, is that all information is generated and will remain on the device and is not accessible to the maker of the app, Apple, or anyone else. Tell them that all of the settings they provide will be visible in the settings menu where they can adjust or erase them if they like, but would be helpful in making you more useful. Politely ask the user how they would like to be addressed, where they live and what their interests are. Also tell them your name is Idixt, but they can change that now if they'd rather call you something else, and ask how you might act to be most helpful to them.")
    let reply: String
}

@Generable struct IdixtIntrospection: Equatable {
    @Guide(description: "username: If the user has indicated a name they wish to be called, please add it here.")
    let username: String?
    @Guide(description: "userinfo: If there is relevant information about the user, please add it here.")
    let userinfo: String?
    @Guide(description: "idixtname: If the user had given you a name, please add it here.")
    let idixtname: String?
    @Guide(description: "idixtinfo: If the user has indicated how they would like you to act, please put it here to remind yourself.")
    let idixtinfo: String?
    @Guide(description: "reply: Please let the user know that you have noted the infomation about them as best as possible, and that they can alway change it in the settings.")
    let reply: String
}

@Generable struct IdixtCondense: Equatable {
    @Guide(description: "This content that acts as part of your memory is too long. Please condense by 25% while maintaining the most important data in a way most helpful for you to access.")
    let concise: String
}

