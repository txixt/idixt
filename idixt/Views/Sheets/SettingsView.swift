//
//  SettingView.swift
//  idixt
//
//  Created by Becket on 6/18/25.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) private var dataContext
    @Binding var gov: Governor
    @Binding var idiot: IdixtModel?
    enum EditField { case none, username, userinfo, idixtname, idixtinfo }
    @State private var editField: EditField = .none
    @FocusState private var editFocus: EditField?
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2).ignoresSafeArea()
            
            ScrollView {
                VStack {
                    Text("Settings").font(.title)
                        .padding(.vertical)
                    Divider()
                        .padding(.bottom)
                    
                    Toggle("Lock App with FaceID", isOn: Binding(
                        get: { gov.userContext.faceidLock },
                        set: { gov.userContext.faceidLock = $0 }
                    ))
                    .buttonStyle(.glass)
                    .tint(.orange)
                    
                    HStack {
                        Image(systemName: "person")
                        if editField != .username { Text("Username: \(gov.userContext.name)") }
                        if editField == .username { TextField("Username: ", text: $gov.userContext.name).focused($editFocus, equals: .username) }
                        Spacer()
                        Button(action: {
                            if editField != .username {
                                editField = .username
                                editFocus = .username
                            } else {
                                editField = .none
                                editFocus = nil
                            }
                        }) {
                            Image(systemName: "square.and.pencil")
                        }
                        .buttonStyle(.glass)
                    }
                    .padding(.vertical)
                    HStack {
                        Image(systemName: "person.bubble")
                        if editField != .userinfo { Text("User Info: \(gov.userContext.info)") }
                        if editField == .userinfo { TextField("User Info: ", text: $gov.userContext.info).focused($editFocus, equals: .userinfo) }
                        Spacer()
                        Button(action: {
                            if editField != .userinfo {
                                editField = .userinfo
                                editFocus = .userinfo
                            } else {
                                editField = .none
                                editFocus = nil
                            }
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
                        if editField == .idixtname { TextField("Model Name: ", text: $gov.idixtContext.name).focused($editFocus, equals: .idixtname) }
                        Spacer()
                        Button(action: {
                            if editField != .idixtname {
                                editField = .idixtname
                                editFocus = .idixtname
                            } else {
                                editField = .none
                                editFocus = nil
                            }
                        }) {
                            Image(systemName: "square.and.pencil")
                        }
                        .buttonStyle(.glass)
                    }
                    .padding(.bottom)
                    HStack {
                        Image(systemName: "ellipsis.bubble").scaleEffect(x: -1.0)
                        if editField != .idixtinfo { Text("Model Info: \(gov.idixtContext.info)") }
                        if editField == .idixtinfo { TextField("Model Info: ", text: $gov.idixtContext.info).focused($editFocus, equals: .idixtinfo) }
                        Spacer()
                        Button(action: {
                            if editField != .idixtinfo {
                                editField = .idixtinfo
                                editFocus = .idixtinfo
                            } else {
                                editField = .none
                                editFocus = nil
                            }
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
                        .tint(.orange)
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
                .onChange(of: gov.idixtContext) { dataContext.insert(gov.idixtContext); resetModel() }
                .onChange(of: gov.userContext) { dataContext.insert(gov.userContext); resetModel() }
            }
        }
    }
    
    private func resetModel() {
        guard let idiot else { return }
        let context = ContextCreator().create(user: gov.userContext, idixt: gov.idixtContext)
        idiot.reset(context: context)
    }
}

#Preview {
    SettingsView(gov: .constant(Governor()), idiot: .constant(IdixtModel()))
}
