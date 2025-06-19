//
//  TitleView.swift
//  idixt
//
//  Created by Becket Bowes on 6/17/25.
//

import SwiftUI

struct TitleView: View {
    @Binding var gov: Governor
    
    var body: some View {
        Text(gov.thread.title).bold().padding(10)
    }
}

#Preview {
    TitleView(gov: .constant(Governor()))
}
