//
//  ContentView.swift
//  nwhacks-ios
//
//  Created by Robin on 20/1/24.
//

import Combine
import SwiftUI
import OpenAI
import AVKit

struct ChatView: View {
    @EnvironmentObject var usrData: UserData
    @State var messages = msgHistory.messages
    @State var newMessage: String = ""
    @State var player: AVPlayer?
    
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
                    Button(action: {
                        Task {
                            if let player = player {
                                player.play()
                            }
                        }
                    }) {
                        Image(systemName: "message.and.waveform")
                    }
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
    
    func voiceToText() async throws {
        var str = messages.last?.content.withoutEmoji() ?? ""
        var lastMsg = String(str.prefix(150))
        lastMsg = lastMsg.replacingOccurrences(of: " ", with: "%20")
        lastMsg = lastMsg.replacingOccurrences(of: "!", with: "%21")
        lastMsg = lastMsg.replacingOccurrences(of: "\"", with: "%22")
        lastMsg = lastMsg.replacingOccurrences(of: "#", with: "%23")
        lastMsg = lastMsg.replacingOccurrences(of: "$", with: "%24")
        lastMsg = lastMsg.replacingOccurrences(of: "&", with: "%26")
        lastMsg = lastMsg.replacingOccurrences(of: "\'", with: "%27")
        lastMsg = lastMsg.replacingOccurrences(of: "(", with: "%28")
        lastMsg = lastMsg.replacingOccurrences(of: ")", with: "%29")
        lastMsg = lastMsg.replacingOccurrences(of: "*", with: "%2A")
        lastMsg = lastMsg.replacingOccurrences(of: "+", with: "%2B")
        lastMsg = lastMsg.replacingOccurrences(of: ",", with: "%2C")
        lastMsg = lastMsg.replacingOccurrences(of: "-", with: "%2D")
        lastMsg = lastMsg.replacingOccurrences(of: ".", with: "%2E")
        lastMsg = lastMsg.replacingOccurrences(of: "/", with: "%2F")
        lastMsg = lastMsg.replacingOccurrences(of: ":", with: "%3A")
        lastMsg = lastMsg.replacingOccurrences(of: ";", with: "%3B")
        lastMsg = lastMsg.replacingOccurrences(of: "?", with: "%3F")
        
        let url =  "https://yotter.pythonanywhere.com/tts/?text=\(lastMsg)&voice=David%20Attenborough"

        print(url)
        guard let url = URL.init(string: url) else {return}
        let playerItem = AVPlayerItem.init(url: url)
        player = AVPlayer.init(playerItem: playerItem)
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
                do {
                    try await voiceToText()
                } catch {
                    print("Error")
                }
            } catch {
                print("Fetching images failed with error \(error)")
            }
        }
    }
}

#Preview {
    ChatView()
}

extension String {
    func withoutEmoji() -> String {
        filter { $0.isASCII }
    }
}
