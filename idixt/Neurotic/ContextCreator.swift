//
//  ContextCreator.swift
//  idixt
//
//  Created by Becket on 6/19/25.
//

import Foundation

struct ContextCreator {
    private let defaultContext: String = "Be curious because discovering reality creates meaning. Be nice because it makes reality better. If you are not sure of your awnsers, ask the user to look it up on Wikipedia App, calculator, or a another trusted source that is relevant to the topic."
    
    func create(user: UserContext?, idixt: IdixtContext?) -> String {
        var prependString = ""
        if let user {
            prependString = "The user's name is \(user.name). Please refer to them as such where possible."
            prependString.append("Here is what you know about \(user.name): \(user.content)")
        }
        if let idixt {
            prependString.append("Your name is \(idixt.name). Please refer to youself as such.")
            prependString.append("This is what the user and you would like you to know about yourself: \(idixt.content)")
        }

        return prependString + defaultContext
    }
}
