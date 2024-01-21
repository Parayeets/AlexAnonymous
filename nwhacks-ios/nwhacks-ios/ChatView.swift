//
//  ContentView.swift
//  nwhacks-ios
//
//  Created by Robin on 20/1/24.
//

import Combine
import SwiftUI
import OpenAI

struct ChatView: View {
    var usrData = userData()
    @State var messages = msgHistory.messages
    @State var newMessage: String = ""
    
    let openAI = OpenAI(apiToken: "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")
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack {
                        ForEach(messages, id: \.self) { message in
                            MessageView(currentMessage: message)
                                .id(message)
                        }
                    }
                    .onReceive(Just(messages)) { _ in
                        withAnimation {
                            proxy.scrollTo(messages.last, anchor: .bottom)
                        }
                        
                    }.onAppear {
                        withAnimation {
                            proxy.scrollTo(messages.last, anchor: .bottom)
                        }
                    }
                }
                
                // send new message
                HStack {
                    TextField("Send a message", text: $newMessage)
                        .textFieldStyle(.roundedBorder)
                    Button(action: {
                        Task {
                            await sendMessage()
                        }
                    })   {
                        Image(systemName: "paperplane")
                    }
                }
                .padding()
            }
        }.preferredColorScheme(.light)
        
        
        
    }
    
    func sendMessage() async {
        
        if !newMessage.isEmpty{
            let queryMsg = newMessage
            newMessage = ""
            
            messages.append(Message(content: queryMsg, isCurrentUser: true))
            let preamble = usrData.generatePreamble()
            
            let query = ChatQuery(model: .gpt4, messages: [.init(role: .system, content: preamble),
                                                           .init(role: .user, content: queryMsg)])
            do {
                let result = try await openAI.chats(query: query)
                messages.append(Message(content: result.choices[0].message.content ?? "", isCurrentUser: false))
                usrData.pastConversations[queryMsg] = result.choices[0].message.content ?? ""
            } catch {
                print("Fetching images failed with error \(error)")
            }
        }
    }
}

#Preview {
    ChatView()
}
