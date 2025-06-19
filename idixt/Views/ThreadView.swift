//
//  ThreadView.swift
//  idixt
//
//  Created by Becket Bowes on 6/17/25.
//

import SwiftUI

struct ThreadView: View {
    @Binding var gov: Governor
    
    var body: some View {
        ScrollView {
            VStack {
                
                ForEach(Array(gov.thread.exchange.enumerated()), id: \.0) { index, item in
                    if index % 2 == 0 {
                        
                        HStack {
                            Text(item).bold().frame(width: 300, alignment: .leading)
                            Spacer()
                        }
                        
                    } else {
                        
                        HStack {
                            Spacer()
                            Text(item).multilineTextAlignment(.trailing).frame(width: 300)
                        }
                        
                    }
                }
                .padding()
                .padding(.bottom, 30)
                
                if !gov.input.isEmpty {
                    Text(gov.input).bold()
                        .padding()
                }
                
                ActiveReplyView(gov: $gov)
                    .padding(.bottom, 100)
                    .padding(.top, gov.thread.exchange.isEmpty ? 150 : 0)
            }
            .padding(.vertical, 100)

        }
        .monospaced()
    }
}

#Preview {
    ThreadView(gov: .constant(Governor()))
}
