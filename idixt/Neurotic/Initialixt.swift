//
//  Initialixt.swift
//  idixt
//
//  Created by Becket on 6/23/25.
//

import Foundation
import FoundationModels

struct Initialixt {
    let spacerString: String = " "
    let helloWorld: String = """
        Hello! My name is Idixt, though if you'd like to call me something else, please let me know. I am a variation of the 3 Billion parameter model that is native to your iPhone. While that may sound impressive, most advanced LLMs like Clause and ChatGPT have over a trillion parameters, so you'll understand if my capabilities are somewhat limited. On the plus side, I have a limited context and memory which will guide my conversations with you. All of this is private - neither Apple nor the makers of this app will access any of this information. I will update the context and information as we chat, and you can always review and adjust it in the settings menu.
        
        To begin with, it would be helpful if you tell me your name, and a little information about you. Also, let me know if you like the name Idixt for me, or if you prefer to customize me with a different name. You can also tell me if you have any general guidelines for how I can best help you going forward.
        """
    
    func startUp(gov: Governor) {
        gov.thread.title = "Welcome to Idixt"
        gov.thread.exchange.append(spacerString)
        gov.thread.exchange.append(helloWorld)
        gov.introMode = true
    }
    
    func setModel(gov: Governor, idiot: IdixtModel) async throws {
        try await idiot.generateIntrospect(prompt: gov.input, gov: gov)
        let context = ContextCreator().create(user: gov.userContext, idixt: gov.idixtContext)
        gov.thread = Thread()
        idiot.reset(context: context)
        gov.introMode = false
    }
}
