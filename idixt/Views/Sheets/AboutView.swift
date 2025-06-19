//
//  AboutView.swift
//  idixt
//
//  Created by Becket on 6/18/25.
//

import SwiftUI

struct AboutView: View {
    @Binding var gov: Governor
    var body: some View {
        VStack {
            Text("About Idixt").font(.headline)
            Spacer()
            Button(action: { gov.mode = nil }) {
                Image(systemName: "xmark")
            }
            .buttonStyle(.glass)
        }
        .padding()
    }
}

#Preview {
    AboutView(gov: .constant(Governor()))
}
