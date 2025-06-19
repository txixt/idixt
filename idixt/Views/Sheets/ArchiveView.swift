//
//  ArchiveView.swift
//  idixt
//
//  Created by Becket on 6/18/25.
//

import SwiftUI

struct ArchiveView: View {
    @Binding var gov: Governor
    var body: some View {
        VStack {
            Text("Idixt Archive").font(.headline)
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
    ArchiveView(gov: .constant(Governor()))
}
