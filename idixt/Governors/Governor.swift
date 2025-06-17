//
//  Governor.swift
//  idixt
//
//  Created by Becket on 6/17/25.
//

import Foundation

@Observable final class Governor {
    var input: String = ""
    var thread: [String] = []
    var title: String = ""
    
    enum GenerationState { case isRecording, isGenerating, idle }
    var genState: GenerationState = .idle
    
    enum ApplicationMode { case currentThread, menu, archiveThread, settings }
    var mode: ApplicationMode = .currentThread
}
