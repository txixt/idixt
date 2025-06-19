//
//  AlertView.swift
//  idixt
//
//  Created by Becket on 6/18/25.
//

import SwiftUI

struct AlertView: View {
    @Binding var gov: Governor
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.thinMaterial)
                .shadow(radius: 5)
                .frame(width: 200, height: 300)
            
            VStack() {
                Image(systemName: "figure.fall")
                    .font(.largeTitle)
                    .foregroundColor(.orange)
                    
                Spacer()
                
                Text("Whoops!")
                    .font(.headline)
                if gov.alertText != nil {
                    Text(gov.alertText!)
                }
                
                Spacer()
                
                Button(action: { gov.alertReport = nil }) {
                    Image(systemName: "xmark")
                }.buttonStyle(.glass)
            
            }
            .padding()
            .frame(width: 200, height: 300)
        }
    }
}

#Preview {
    AlertView(gov: .constant(Governor()))
}
