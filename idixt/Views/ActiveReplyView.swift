//
//  ActiveReplyView.swift
//  idixt
//
//  Created by Becket Chambliss on 6/17/25.
//

import SwiftUI

struct ActiveReplyView: View {
    @Binding var gov: Governor
    @State var xOffset: CGFloat = 0
    @State var yOffset: CGFloat = 0
    
    var body: some View {
        HStack(alignment: .bottom) {
            
            Spacer()
            
            ZStack(alignment: .top) {
                VStack(alignment: .center) {
                    if gov.activeReply != nil {
                        Text(gov.activeReply!)
                            .font(.system(size: 17, weight: .regular, design: .monospaced))
                            .multilineTextAlignment(.trailing)
                            .frame(maxWidth: 300, alignment: .center)
                            .monospaced()
                            .lineLimit(nil)
                            .offset(x: -35)
                    }

                }
                CursorView(gov: $gov)
                    .offset(x: xOffset, y: yOffset)
            }
        }
        .padding(.trailing, 15)
        .onChange(of: gov.activeReply) {
            cursorOffset()
        }
        .task {
            cursorOffset()
        }
    }
    
    private func cursorOffset() {
        let characterWidth: CGFloat = 6.2
        let lineHeight: CGFloat = 20.5
        let currentLine = (((gov.activeReply?.count ?? 0) * Int(characterWidth)) / 150)
        xOffset = currentLine == 0 ? CGFloat((gov.activeReply?.count ?? 0) * Int(characterWidth)) + (characterWidth * 2) : 152
        yOffset = (CGFloat(currentLine) * lineHeight) - 33
    }
}

#Preview {
    ActiveReplyView(gov: .constant(Governor()))
}
