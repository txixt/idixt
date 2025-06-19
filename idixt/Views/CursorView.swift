//
//  CursorView.swift
//  idixt
//
//  Created by Becket on 6/17/25.
//

import SwiftUI

struct CursorView: View {
    @Binding var gov: Governor
    @State var curse: Curse = Curse()
    
    var body: some View {
        
        ZStack {
            MeshGradient(
                width: 3,
                height: 3,
                points: [
                    [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                    [0.0, 0.5], 1 - curse.cursorSpring, [1.0, 0.5],
                    [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                ],
                colors: [
                    .clear, .clear, .clear,
                    .clear, .curseBottom, .clear,
                    .clear, .clear, .clear
                ]
            )
            .frame(width: 80, height: 100)
            
            MeshGradient(
                width: 3,
                height: 3,
                points: [
                    [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                    [0.0, 0.5], curse.cursorSpring, [1.0, 0.5],
                    [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                ],
                colors: [
                    .clear, .clear, .clear,
                    .clear, .curseTop, .clear,
                    .clear, .clear, .clear
                ]
            )
            .frame(width: 50, height: 70)
            
            Text("▮.▮")
                .bold()
                .monospaced(false)
                .padding(.vertical, 10)
                .glassEffect(.regular.tint(.clear), in: .rect(cornerRadius: 3))
                .foregroundColor(curse.cursorBlink ? .black : .clear)
                .rotationEffect(gov.genState == .isGenerating ? .degrees(11) : .degrees(0))

        }
        .offset(x: -19.5, y: -19)
    }
}

#Preview {
    CursorView(gov: .constant(Governor()))
}
