//
//  IdixtModel.swift
//  idixt
//
//  Created by Becket Bowes on 6/17/25.
//

import Foundation
import FoundationModels

@Observable
@MainActor
final class IdixtModel {
    private let session: LanguageModelSession?
    private var localContext: String? = nil
    var reply: IdixtReply? = nil
    
    init() {
        let defaultContext: String = "Be curious. If you are not sure of your awnsers, ask the user to look it up on Wikipedia App, calculator, or a another trusted source that is relevant to the topic. Reason through your answer logically in the COT. Then find the most fun metaphor to explain to the user in the Reply."
        session = LanguageModelSession { defaultContext }
    }
    
    func generateReply(prompt: String) async throws -> String  {
        var response: String = "initial string"
        do {
            let initialReply = try await session?.respond(to: prompt)
            guard initialReply != nil else { return "response recieved, but unable to unwrap" }
            response = initialReply!.content
        } catch {
            return "there was an issue loading the model "
        }

        return response
    }
}

//    private let introContext: String = "Explain that you are a basic 3 billion parameter model that runs locally on the iPhone, that all information is generated and will remain on the device and is not accessible to the maker of the app, apple, or anyone else. Tell them that all of the settings they provide will be visible in the settings menu where they can adjust or erase them if they like, but would be helpful in making you more useful. Politely ask the user how they would like to be addressed and how they would like to address you."

//    static func createContext(userName: String?, userContext: String?, sessionName: String?, sessionContext: String?) {
//        var context = defaultContext
//        if userName == nil && userContext == nil && sessionName == nil && sessonContext == nil {
//            context = introContext
//        }
//        if userName != nil { context = "You are in conversation with \(userName)" + context }
//        if userContext != nil { context = context}
//    }
