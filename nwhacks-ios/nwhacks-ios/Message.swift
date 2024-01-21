//
//  Message.swift
//  nwhacks-ios
//
//  Created by Robin on 20/1/24.
//

import Foundation

struct Message: Hashable {
    var id = UUID()
    var content: String
    var isCurrentUser: Bool
}

struct DataSource {
    
    static let messages = [
        Message(content: "Hi there! How can I help you today?", isCurrentUser: false)
    ]
}

