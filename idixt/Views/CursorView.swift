//
//  CursorView.swift
//  idixt
//
//  Created by Becket on 6/17/25.
//

import SwiftUI

struct CursorView: View {
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
                    .clear, .cursorSeven, .clear,
                    .clear, .clear, .clear
                ]
            )
            .frame(width: 30, height: 40)
            
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
                    .clear, .cursorSix, .clear,
                    .clear, .clear, .clear
                ]
            )
            .frame(width: 50, height: 60)
            
            
            if #available(iOS 26.0, *) {
                
                Text("▮.▮")
                    .padding(3)
                    .glassEffect(in: .rect(cornerRadius: 3))
                    .foregroundColor(curse.cursorBlink ? .black : .clear)
                
            } else {
                
                ZStack {
                    MeshGradient(
                        width: 4,
                        height: 4,
                        points: [
                            [0.0, 0.0], [0.05, 0.0], [0.95, 0.0], [1.0, 0.0],
                            [0.0, 0.05], [0.05, 0.05], [0.95, 0.05], [1.0, 0.05],
                            [0.0, 0.95], [0.05, 0.95], [0.95, 0.95], [1.0, 0.95],
                            [0.0, 1.0], [0.05, 1.0], [0.95, 1.0], [1.0, 1.0]
                        ],
                        colors: [
                            .cursorOne, .cursorOne, .cursorOne, .cursorOne,
                            .cursorOne, .cursorFive, .cursorFive, .cursorOne,
                            .cursorOne, .cursorFive, .cursorFive, .cursorOne,
                            .cursorOne, .cursorOne, .cursorOne, .cursorOne
                        ]
                    )
                    .frame(width: 11, height: 22)
                    .cornerRadius(1)
                    
                    MeshGradient(
                        width: 4,
                        height: 5,
                        points: [
                            [0.0, 0.0], [0.1, 0.0], [0.9, 0.0], [1.0, 0.0],
                            [0.0, 0.1], [0.1, 0.1], [0.9, 0.1], [1.0, 0.1],
                            [0.0, 0.15], [0.1, 0.35], [0.9, 0.15], [1.0, 0.15],
                            [0.0, 0.7], [0.1, 0.7], [0.9, 0.5], [1.0, 0.7],
                            [0.0, 1.0], [0.1, 1.0], [0.9, 1.0], [1.0, 1.0]
                        ],
                        colors: [
                            .clear, .clear, .clear, .clear,
                            .clear, .cursorTwo, .cursorTwo, .clear,
                            .clear, .cursorThree, .cursorThree, .clear,
                            .clear, .cursorThree, .cursorThree, .clear,
                            .clear, .clear, .clear, .clear
                        ]
                    )
                    .frame(width: 11, height: 22)
                    .cornerRadius(1)
                }
                .opacity(curse.cursorBlink ? 0.0 : 1.0)

            }
        }
        .offset(x: -19.5, y: -19)
    }
}

#Preview {
    CursorView()
}
