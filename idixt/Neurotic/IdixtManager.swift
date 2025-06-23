//
//  IdixtManager.swift
//  idixt
//
//  Created by Becket on 6/19/25.
//

import Foundation
import FoundationModels

//struct IdixtManager {
//    func continueConversation(idiot: IdixtModel?, gov: Governor) async throws {
//        guard let idiot, let session = idiot.session else { print("error loading model"); return }
//        let transcriptString: String = session.transcript.entries.description.map { $0.description }.joined(separator: "\n")
//        let condensate = try await idiot.generateCondense(text: transcriptString)
//        let
//    }
//}

//struct IntroManager {
//    func introduce(idiot: IdixtModel?, gov: Governor) async throws {
//        guard let idiot else { print("error loading model"); return }
//        gov.introMode = true
//        
//        do {
//            try await idiot.generateIntroduce()
//            if idiot.reply != nil {
//                gov.activeReply = idiot.reply!
//                IntroTimer().setTime(idiot: idiot, gov: gov)
//            }
//        }
//    }
//    
//    func followUpIntro(idiot: IdixtModel?, gov: Governor) async throws {
//        guard let idiot else { print("error loading model"); return }
//        do {
//            try await idiot.generateIntrospect(prompt: gov.input, gov: gov)
//        }
//        gov.introMode = false
//        gov.input = ""
//        resetModel(idiot: idiot, gov: gov)
//    }
//    
//    private func resetModel(idiot: IdixtModel?, gov: Governor) {
//        guard let idiot else { print("error loading model"); return }
//        let context = ContextCreator().create(user: gov.userContext, idixt: gov.idixtContext)
//        idiot.reset(context: context)
//    }
//}
//
//final class IntroTimer {
//    private var timer: Timer?
//
//    func setTime(idiot: IdixtModel, gov: Governor) {
//        timer?.invalidate()
//        timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: false) { _ in
//            // Always dispatch UI/model updates to the main actor
//            Task { @MainActor in
//                if gov.input.isEmpty {
//                    let context = ContextCreator().create(user: gov.userContext, idixt: gov.idixtContext)
//                    idiot.reset(context: context)
//                }
//            }
//        }
//    }
//
//    func invalidate() {
//        timer?.invalidate()
//        timer = nil
//    }
//}
