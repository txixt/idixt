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
    var cot: String? = nil
    var reply: String? = nil
    var sysString: String? = nil
    
    init(context: String? = nil) {
        let defaultContext = "Be curious because discovering reality creates meaning. Be nice because it makes reality better. If you are not sure of your awnsers, ask the user to look it up on Wikipedia App, calculator, or a another trusted source that is relevant to the topic."
        let contextString = context ?? defaultContext
        session = LanguageModelSession { contextString }
    }
    
    func generateReply(prompt: String, gov: Governor) async throws -> String {
        guard let session else { print("NO SESSION! at generateReply"); return "error creating session" }
        do {
            let iReply = try await session.respond(generating: IdixtReply.self) { "Reply to the following: \(prompt)" }
            cot = iReply.content.cot
            reply = iReply.content.reply
            if iReply.content.localContext != nil { gov.thread.localContext = iReply.content.localContext! }
            introspect(
                username: iReply.content.username,
                userinfo: iReply.content.userinfo,
                idixtname: iReply.content.idixtname,
                idixtinfo: iReply.content.idixtinfo,
                gov: gov)
            return reply ?? "error generating reply"
        }
    }
    
    func generateIntroduce() async throws {
        guard let session else { print("NO SESSION! at genrateIntroduce"); return }
        do {
            let iIntro = try await session.respond(generating: Introduction.self) { "Welcome to the world. Please introduce yourself." }
            reply = iIntro.content.reply
        }
    }
    
    func generateIntrospect(prompt: String, gov: Governor) async throws {
        guard let session else { print("NO SESSION! at generateIntrospect"); return }
        do {
            let iSpect = try await session.respond(generating: IdixtIntrospection.self) { "Please use the following prompt to initialize as much info possible about the user and yourself, and reply as prompted." }
            reply = iSpect.content.reply
            introspect(
                username: iSpect.content.username,
                userinfo: iSpect.content.usercontent,
                idixtname: iSpect.content.idixtname,
                idixtinfo: iSpect.content.idixtcontent,
                gov: gov)
        }
    }
    
    func generateCondense(text: String) async throws {
        guard let session else { print("NO SESSION at generateCondense"); return }
        do {
            let iCondense = try await session.respond(generating: IdixtCondense.self) { "Condense the following: \(text)" }
            sysString = iCondense.content.concise
        }
    }
    
    private func introspect(username: String?, userinfo: String?, idixtname: String?, idixtinfo: String?, gov: Governor) {
        if username != nil {
            if gov.userContext == nil { gov.userContext = UserContext(name: username!) }
            else { gov.userContext!.name = username! }
        }
        if userinfo != nil {
            if gov.userContext == nil { gov.userContext = UserContext(content: userinfo!) }
            else { gov.userContext!.content = userinfo! }
        }
        if idixtname != nil {
            if gov.idixtContext == nil { gov.idixtContext = IdixtContext(name: idixtname!) }
            else { gov.idixtContext!.name = idixtname! }
        }
        if idixtinfo != nil {
            if gov.idixtContext == nil { gov.idixtContext = IdixtContext(content: idixtinfo!) }
            else { gov.idixtContext!.name = idixtinfo! }
        }
    }
}


//    func generateReply(prompt: String) async throws -> String  {
//        do {
//            let initialReply = try await session?.respond(to: prompt)
//            guard initialReply != nil else { return "response recieved, but unable to unwrap" }
//            return initialReply!.content
//        } catch {
//            return "there was an issue loading the model "
//        }
//    }

//    private let introContext: String = "Explain that you are a basic 3 billion parameter model that runs locally on the iPhone, that all information is generated and will remain on the device and is not accessible to the maker of the app, apple, or anyone else. Tell them that all of the settings they provide will be visible in the settings menu where they can adjust or erase them if they like, but would be helpful in making you more useful. Politely ask the user how they would like to be addressed and how they would like to address you."

//    static func createContext(userName: String?, userContext: String?, sessionName: String?, sessionContext: String?) {
//        var context = defaultContext
//        if userName == nil && userContext == nil && sessionName == nil && sessonContext == nil {
//            context = introContext
//        }
//        if userName != nil { context = "You are in conversation with \(userName)" + context }
//        if userContext != nil { context = context}
//    }

