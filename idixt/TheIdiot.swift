//
//  TheIdiot.swift
//  idixt
//
//  Created by Becket Chambliss on 6/10/25.
//

import Foundation
import FoundationModels
import Playgrounds

#Playground {
    let session = try LanguageModelSession(instructions: "please think through the question asked for a paragraph and come up with the best one sentence answer. Bonus points if you use a spoonerism, haiku, rhyme or other wordplay. Then reply with a paragraph that finds the most fun way of getting to the answer you end with - think unexpected metaphor, or 'personal' story. If the answer might be wrong, don't be afraid to say so.")
    let reply = try await session.respond(to: "What do you know about Noam Chomsky?")
}

@Generable struct BasicString {
    let reasoning: String
    let answer: String
    let reply: String
}

@Generable struct Coordinates {
    let title: String
    let latitude: Float
    let longitude: Float
}

@Generable struct Contacts {
    let firstname: String
    let lastname: String
}

//public protocol Tool: Sendable {
//    var name: String { get }
//    var description: String { get }
//    associatedtype Arguments: ConvertibleFromGeneratedContent
//    
//    func call(arguments: Arguments) async throws -> ToolOutput
//}

//struct findLocationTool: Tool {
//    let name = "findLocation"
//    let description = "find coordinates of the location the user referred to."
//    
//    let coordinates: Coordinates
//    
//    @Generable struct Arguments {
//        @Guide(description: "the are the user's contacts in order of most contacted")
//        let contacts: Contacts
//    }
//    
//    func call(arguments: Arguments) async throws -> ToolOutput {}
//}
