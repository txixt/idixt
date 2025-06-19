//
//  IdixtTools.swift
//  idixt
//
//  Created by Becket on 6/19/25.
//

import Foundation
import FoundationModels

public protocol Tool: Sendable {
    var name: String { get }
    var description: String { get }
    associatedtype Arguments: ConvertibleFromGeneratedContent
    func call(aruments: Arguments) async throws -> ToolOutput
}
