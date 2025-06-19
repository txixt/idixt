//
//  Cursor.swift
//  idixt
//
//  Created by Becket on 6/17/25.
//

import Foundation
import SwiftUI

@Observable final class Curse {
    var cursorBlink: Bool = false
    var cursorSpring: SIMD2<Float> = [0.5, 0.5]
    
    init() { startAnimation() }
    
    private func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 1.0)) {
                    for i in 0...1 {
                        let randomChange = Float.random(in: -0.1...0.1)
                        let newValue = self.cursorSpring[i] + randomChange
                        self.cursorSpring[i] = min(0.8, max(0.2, newValue))
                    }
                }
                withAnimation(.spring(duration: 0.25)) {
                    self.cursorBlink.toggle()
                }
            }
        }
    }
}
