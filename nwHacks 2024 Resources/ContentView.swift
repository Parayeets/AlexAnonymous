//
//  ContentView.swift
//  nwHacks 2024 Resources
//
//  Created by Eden Kim on 2024-01-20.
//

import SwiftUI

struct Colors {
    static let background = Color("Color")
}

struct helpline: Identifiable {
    let id = UUID()
    let name: String
    let phone: String
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: StudyView()) {
                    HStack {
                        Text("Articles")
                    }
                }
                NavigationLink(destination: ContactsView()) {
                    HStack {
                        Text("Contacts")
                    }
                }
                NavigationLink(destination: HelplineView()) {
                    HStack {
                        Text("Get Help")
                    }
                }
            }
            .navigationTitle("Resources")
        }
    }
}

struct StudyView: View {
    var body: some View {
        List {
            Text("[Relapse Prevention and the Five Rules of Recovery](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4553654/)")
            Text("[Relapse Prevention](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5844157/)")
            Text("[How to Help a Friend with Addiction](https://drugfree.org/article/how-to-help-a-friend-with-addiction/)")
            Text("[Understanding and Avoiding Relapse into Addiction](https://www.hazeldenbettyford.org/articles/relapse-risks-stats-and-warning-signs)")
        }
        
    }
}

struct ContactsView: View {
    @State var people = ["Dad", "Mom", "Sibling", "Friend"]
    var body: some View {
        List {
            ForEach(people, id: \.self) { person in
                HStack {
                    Image("Image")
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        .frame(width: 30, height: 30)
                    Text(person)
                    Spacer()
                    Image("Call")
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        .frame(width: 30, height: 30)
                    Image("Message")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30, height: 30)
                    Image("Video Call")
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        .frame(width: 30, height: 30)
                }
            }
        }
        .navigationTitle("Contacts")
    }
}


struct HelplineView: View {
    
    var body: some View {
        List {
            Text("[Wellness Together Canada](https://www.wellnesstogether.ca/en-ca/)")
                .listRowSeparator(.hidden)
            Link("1-866-585-0445", destination: URL(string: "tel:18665850445")!)
            Spacer()
            Text("[Kids Help Phone](https://kidshelpphone.ca/)")
                .listRowSeparator(.hidden)
            Link("1-800-668-6868", destination: URL(string: "tel:18006686868")!)
            Spacer()
            Text("[Narcotics Anonymous](https://canaacna.org/)")
                .listRowSeparator(.hidden)
            Link("1-855-562-2262", destination: URL(string: "tel:18555622262")!)
            Spacer()
            Text("[Families for Addiction Recovery](https://www.farcanada.org/)")
                .listRowSeparator(.hidden)
            Link("1-855-377-6677", destination: URL(string: "tel:18553776677")!)
        }
        .navigationTitle("Helplines")
    }
}

#Preview {
    ContentView()
}
