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
    var session: LanguageModelSession?
    var idixtReply: IdixtReply?.PartiallyGenerated?
    var introduction: Introduction?.PartiallyGenerated?
    var introspection: IdixtIntrospection?.PartiallyGenerated?
    var reply: String? = nil
    
    init(context: String? = nil) {
        let defaultContext = "Be curious because discovering reality creates meaning. Be nice because it makes reality better. If you are not sure of your awnsers, ask the user to look it up on Wikipedia App, calculator, or a another trusted source that is relevant to the topic."
        let contextString = context ?? defaultContext
        session = LanguageModelSession { contextString }
    }
    
    func generateReply(prompt: String, gov: Governor) async throws {
        guard let session else {
            gov.alertReport = .modelGenerationFail
            gov.alertText = "It looks like you don't have AI enabled on your phone. Please adjust your settings to proceed."
            return
        }
        do {
            let stream = session.streamResponse(to: prompt, generating: IdixtReply.self, options: GenerationOptions(temperature: Double(gov.idixtContext?.temp ?? 1.1)))
            for try await thread in stream {
                idixtReply = thread
                gov.activeReply = thread.reply
            }
            let structure = try await stream.collect()
            gov.thread.localContext.append(structure.content.localContext)
            gov.thread.title = structure.content.title
            introspect(
                username: structure.content.username,
                userinfo: structure.content.userinfo,
                idixtname: structure.content.idixtname,
                idixtinfo: structure.content.idixtinfo,
                gov: gov)
        } catch LanguageModelSession.GenerationError.exceededContextWindowSize {
            self.session = nil
            self.session = LanguageModelSession()
            var transcriptSummary = gov.thread.localContext
            if transcriptSummary.count > 2000 { transcriptSummary = try await generateCondense(text: transcriptSummary) }
            let context = ContextCreator().create(user: gov.userContext, idixt: gov.idixtContext)
            self.session = nil
            self.session = LanguageModelSession { context + transcriptSummary }
        } catch LanguageModelSession.GenerationError.assetsUnavailable {
            gov.alertReport = .modelGenerationFail
            gov.alertText = "Something went wrong. Please try again later."
        } catch LanguageModelSession.GenerationError.guardrailViolation {
            gov.alertReport = .modelGenerationFail
            gov.alertText = "Guardrail error"
        }
    }
    
//    func generateTitle(prompt: String, gov: Governor) async throws {
//        guard let session else { print("NO SESSION! at generateTitle"); return }
//        do {
//            let structure = try await session.respond(to: prompt, generating: IdixtTitle.self)
//            gov.thread.title = structure.content.title
//        }
//    }
    
    func generateIntroduce() async throws {
        guard let session else { print("NO SESSION! at genrateIntroduce"); return }
        do {
            let stream = session.streamResponse(to: "Welcome to the world. Please introduce yourself.", generating: Introduction.self)
            for try await thread in stream {
                introduction = thread
                reply = thread.reply
            }
        }
    }
    
    func generateIntrospect(prompt: String, gov: Governor) async throws {
        guard let session else { print("NO SESSION! at generateIntrospect"); return }
        do {
            let stream = session.streamResponse(to: "Input any information available from the following \(prompt)", generating: IdixtIntrospection.self)
            for try await thread in stream {
                introspection = thread
                reply = thread.reply
            }
            let structure = try await stream.collect()
            introspect(
                username: structure.content.username,
                userinfo: structure.content.userinfo,
                idixtname: structure.content.idixtname,
                idixtinfo: structure.content.idixtinfo,
                gov: gov)
        }
    }
    
    func generateCondense(text: String) async throws -> String {
        guard let session else { print("NO SESSION at generateCondense"); return "error condensing text" }
        do {
            let iCondense = try await session.respond(generating: IdixtCondense.self) { "Condense the following: \(text)" }
            return iCondense.content.concise
        }
    }
    
    private func introspect(username: String?, userinfo: String?, idixtname: String?, idixtinfo: String?, gov: Governor) {
        if username != nil {
            if gov.userContext == nil { gov.userContext = UserContext(name: username!) }
            else { gov.userContext!.name = username! }
        }
        if userinfo != nil {
            if gov.userContext == nil { gov.userContext = UserContext(info: userinfo!) }
            else { gov.userContext!.info = userinfo! }
        }
        if idixtname != nil {
            if gov.idixtContext == nil { gov.idixtContext = IdixtContext(name: idixtname!) }
            else { gov.idixtContext!.name = idixtname! }
        }
        if idixtinfo != nil {
            if gov.idixtContext == nil { gov.idixtContext = IdixtContext(info: idixtinfo!) }
            else { gov.idixtContext!.name = idixtinfo! }
        }
    }
    
    func prewarm() {
        session?.prewarm()
    }
    
    func reset(context: String) {
        session = nil
        session = LanguageModelSession { context }
    }
}
//import Playgrounds

//#Playground {
//    let session = try await LanguageModelSession { "Be curious because discovering reality creates meaning. Be nice because it makes reality better. If you are not sure of your awnsers, ask the user to look it up on Wikipedia App, calculator, or a another trusted source that is relevant to the topic."}
//    let structure = try await session.respond(to: "Hey, my name is actually Becket, not Beckett. Can i call you Tethyx? I was wondering about some of the moons of Saturn and if any of them are as big as our moon. Also, can you generally make your answers a bit shorter?", generating: IdixtReply.self)
//    let reply = structure.content.reply
//    let localContext = structure.content.localContext
//    if let username = structure.content.username {
//        print("Hello \(username)!")
//    }
//    if let userinfo = structure.content.userinfo {
//        print("\(userinfo)")
//    }
//    if let idixtname = structure.content.idixtname {
//        print("\(idixtname)")
//    }
//    if let idixtinfo = structure.content.idixtinfo {
//        print("\(idixtinfo)")
//    }
//
//    let introStructure = try await session.respond(to: "introduce yourself", generating: Introduction.self)
//    let introReply = introStructure.content.reply
//
//    let spectStructure = try await session.respond(to: "Hello. please call yourself Hortence. My name is Fred Durst. It would be great if you could give me facts about things i'm not necessarily asking you about as well as answer my questions. I live in Colorado and have a masters in Communication. I am a writer and a teacher. I am interested in politics and social issues.", generating: IdixtIntrospection.self)
//    let spectReply = spectStructure.content.reply
//    let username = spectStructure.content.username
//    let userinfo = spectStructure.content.userinfo
//    let idixtname = spectStructure.content.idixtname
//    let idixtcontent = spectStructure.content.idixtinfo
//}


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

