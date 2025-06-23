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
            Text("About").font(.title)
                .padding(.vertical)
            Divider()
                .padding(.bottom)
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text("""
                Idixt is a simple interface for Apple's native language model that adds generated memory and context to the user interaction. All information is kept on device and made accessable and erasable by the user. We do not collect any user content.
                
                Apple's native, on-device model has about 3 billion parameters. For context, LLMs like Claude and ChatGPT (at the time of writing) run somewhere over a trillion parameters. While the size of this on-device version is at the limits of what the hardware of an iPhone can manage, it obviously can't compete with the extremely advanced cutting edge models. However, we are hoping that it's a nice example of what can be done as an 'edge case' (computing kept on device, and off of the cloud).
                
                If you have any idea or suggestions for improvements, please contact us through the contact form on our website which is linked on the licence below.
                """)
                }

            }
            Spacer()
            Link("mit licence \(String(Calendar.current.component(.year, from: Date()))) +×ı×+",
                 destination: URL(string: "https://www.txixt.com")!)
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.bottom)
            Button(action: { gov.mode = nil }) {
                Image(systemName: "xmark")
            }
            .buttonStyle(.glass)
        }
        .padding()
        .monospaced()
    }
}

#Preview {
    AboutView(gov: .constant(Governor()))
}
