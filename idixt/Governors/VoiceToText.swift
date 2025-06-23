//
//  VoiceToText.swift
//  idixt
//
//  Created by Becket on 6/23/25.
//

import Foundation
import Speech

@Observable class VoiceToText {
    private let recognizer = SFSpeechRecognizer()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    var isPermitted: Bool = false
    var isRecording: Bool = false
    var transcript: String = ""
    
    func start() -> String? {
        guard !audioEngine.isRunning else { return "Error: Speech already recording." }
        if !isPermitted { requestSpeechAuthorization() } 
        transcript = ""
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { return "Error: Could not create recognition request" }
        recognitionRequest.shouldReportPartialResults = true
        recognitionTask?.cancel()
        recognitionTask = recognizer?.recognitionTask(with: recognitionRequest) { [weak self] result, error in
            guard let self = self else { return }
            if let result = result {
                self.transcript = result.bestTranscription.formattedString
            }
            if error != nil || (result?.isFinal ?? false) {
                self.audioEngine.stop()
                node.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
                self.isRecording = false
            }
        }
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.recognitionRequest?.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
            isRecording = true
        } catch {
            isRecording = false
            transcript = "Audio engine couldn't start: \(error.localizedDescription)"
        }
        return nil
    }
    
    func stop() {
        if audioEngine.isRunning {
            audioEngine.stop()
            audioEngine.inputNode.removeTap(onBus: 0)
        }
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
        isRecording = false
    }
    
    func requestSpeechAuthorization() {
        SFSpeechRecognizer.requestAuthorization { status in
            DispatchQueue.main.async {
                self.isPermitted = (status == .authorized)
            }
        }
    }
}
