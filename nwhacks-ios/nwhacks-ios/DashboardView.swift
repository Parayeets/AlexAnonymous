//
//  TabView.swift
//  nwhacks-ios
//
//  Created by Robin on 21/1/24.
//

import SwiftUI

struct DashboardView: View {
    
    @EnvironmentObject var usrData: UserData
    
    var body: some View {
        TabView {
            ProgressView()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .environmentObject(usrData)
            
            ChatView()
                .tabItem { Label("Chat", systemImage: "message.fill") }
                .environmentObject(usrData)
            
            ResourceView()
                .tabItem { Label("Resources", systemImage: "link") }
                .environmentObject(usrData)
        }.navigationBarBackButtonHidden(true)
    }
}
