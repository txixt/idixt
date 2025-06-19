//
//  SettingView.swift
//  idixt
//
//  Created by Becket on 6/18/25.
//

import SwiftUI

struct SettingsView: View {
    @Binding var gov: Governor
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2).ignoresSafeArea()
            
            ScrollView {
                VStack {
                    Text("Idixt Settings").font(.headline)
                    
                    if let userContext = gov.userContext {
                        Toggle("Lock App with FaceID", isOn: Binding(
                            get: { userContext.faceidLock },
                            set: { userContext.faceidLock = $0 }
                        ))
                    }
                    
                    HStack {
                        Image(systemName: "person")
                        Text("Username: ")
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "square.and.pencil")
                        }
                        .buttonStyle(.glass)
                    }
                    .padding(.vertical)
                    HStack {
                        Image(systemName: "person.bubble")
                        Text("User Information: ")
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "square.and.pencil")
                        }
                        .buttonStyle(.glass)
                    }
                    .padding(.bottom)
                    
                    Divider()
                        .padding(.bottom)
                    
                    HStack {
                        Text("▮.▮").background(.black).foregroundColor(.white).monospaced(false).font(.caption)
                        Text("Modelname: ")
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "square.and.pencil")
                        }
                        .buttonStyle(.glass)
                    }
                    .padding(.bottom)
                    HStack {
                        Image(systemName: "ellipsis.bubble").scaleEffect(x: -1.0)
                        Text("Model Information: ")
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "square.and.pencil")
                        }
                        .buttonStyle(.glass)
                    }
                    .padding(.bottom)
                    
                    Spacer()
                    Button(action: { gov.mode = nil }) {
                        Image(systemName: "xmark")
                    }
                    .buttonStyle(.glass)
                    
                }
                .padding()
                .monospaced()
            }
        }
        

    }
}

#Preview {
    SettingsView(gov: .constant(Governor()))
}
