//
//  ContentView.swift
//  nwhacks-ios
//
//  Created by Robin on 20/1/24.
//

import Combine
import SwiftUI
import OpenAI

struct ContentView: View {
    @State var messages = DataSource.messages
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
            
            let query = ChatQuery(model: .gpt3_5Turbo, messages: [.init(role: .system, content: "You are a helpful and joyous mental therapy assistant. Always answer as helpfully and cheerfully as possible, while being safe. Your answers should not include any harmful, unethical, racist, sexist, toxic, dangerous, or illegal content. Please ensure that your responses are socially unbiased and positive in nature. If a question does not make any sense, or is not factually coherent, explain why instead of answering something not correct. If you don't know the answer to a question, please don't share false information."),
                                                                  .init(role: .user, content: queryMsg)])
            do {
                let result = try await openAI.chats(query: query)
                messages.append(Message(content: result.choices[0].message.content ?? "", isCurrentUser: false))
            } catch {
                print("Fetching images failed with error \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
