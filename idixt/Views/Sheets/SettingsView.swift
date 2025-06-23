//
//  SettingView.swift
//  idixt
//
//  Created by Becket on 6/18/25.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Binding var gov: Governor
    enum EditField { case none, username, userinfo, idixtname, idixtinfo }
    @State var editField: EditField = .none
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2).ignoresSafeArea()
            
            ScrollView {
                VStack {
                    Text("Idixt Settings").font(.headline)
                        .padding(.bottom)
                    
                    Toggle("Lock App with FaceID", isOn: Binding(
                        get: { gov.userContext.faceidLock },
                        set: { gov.userContext.faceidLock = $0 }
                    ))
                    .buttonStyle(.glass)
                    
                    HStack {
                        Image(systemName: "person")
                        if editField != .username { Text("Username: \(gov.userContext.name)") }
                        if editField == .username { TextField("Username: ", text: $gov.userContext.name) }
                        Spacer()
                        Button(action: {
                            if editField != .username { editField = .username }
                            if editField == .username { editField = .none }
                        }) {
                            Image(systemName: "square.and.pencil")
                        }
                        .buttonStyle(.glass)
                    }
                    .padding(.vertical)
                    HStack {
                        Image(systemName: "person.bubble")
                        if editField != .userinfo { Text("User Info: \(gov.userContext.info)") }
                        if editField == .userinfo { TextField("User Info: ", text: $gov.userContext.info) }
                        Spacer()
                        Button(action: {
                            if editField != .userinfo { editField = .userinfo }
                            if editField == .userinfo { editField = .none}
                        }) {
                            Image(systemName: "square.and.pencil")
                        }
                        .buttonStyle(.glass)
                    }
                    .padding(.bottom)
                    
                    Divider()
                        .padding(.bottom)
                    
                    HStack {
                        Text("▮.▮").background(.black).foregroundColor(.white).monospaced(false).font(.caption)
                        if editField != .idixtname { Text("Model Name: \(gov.idixtContext.name)") }
                        if editField == .idixtname { TextField("Model Name: ", text: $gov.idixtContext.name) }
                        Spacer()
                        Button(action: {
                            if editField != .idixtname { editField = .idixtname }
                            if editField == .idixtname { editField = .idixtname }
                        }) {
                            Image(systemName: "square.and.pencil")
                        }
                        .buttonStyle(.glass)
                    }
                    .padding(.bottom)
                    HStack {
                        Image(systemName: "ellipsis.bubble").scaleEffect(x: -1.0)
                        if editField != .idixtinfo { Text("Model Info: \(gov.idixtContext.info)") }
                        if editField == .idixtinfo { TextField("Model Info: ", text: $gov.idixtContext.info) }
                        Spacer()
                        Button(action: {
                            if editField != .idixtinfo { editField = .idixtinfo }
                            if editField == .idixtinfo { editField = .none }
                        }) {
                            Image(systemName: "square.and.pencil")
                        }
                        .buttonStyle(.glass)
                    }
                    .padding(.bottom)
                    HStack {
                        Slider(
                            value: $gov.idixtContext.temp,
                            in: 0.5...2.0,
                            minimumValueLabel: Text("predictable"),
                            maximumValueLabel: Text("creative"),
                            label: { Image(systemName: "thermometer.medium") }
                        )
                        .tint(.red)
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
