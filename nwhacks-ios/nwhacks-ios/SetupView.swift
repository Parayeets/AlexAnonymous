//
//  SetupView.swift
//  nwhacks-ios
//
//  Created by Robin on 20/1/24.
//

import SwiftUI

struct SetupView: View {
    
    @ObservedObject var usrData = UserData()
    @State var whichQn = 0
    @State var txtField = ""
    @State var date = Date.now
    @State var freqWeek: Double = 1
    @State private var willMoveToNextScreen = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    
                    Text("Hey,\nIt's great to meet you.")
                        .fontWeight(.heavy)
                        .font(.title)
                        .frame(width: 300)
                        .padding(.top, 100)
                        .foregroundStyle(.black)
                    
                    Text("I'm Ansel and I'm here to help you stay on track with your sobriety.")
                        .font(.title3)
                        .frame(width: 300)
                        .padding(.top, 5)
                        .foregroundStyle(.black)
                    
                    if whichQn == 0 {
                        namePick
                    } else if whichQn == 1 {
                        recPick
                    } else if whichQn == 2 {
                        fromPick
                    } else if whichQn == 3 {
                        reasonPick
                    } else if whichQn == 4 {
                        resourcePick
                    }
                    
                    Spacer()
                    
                }
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                .background(Image("welcome_image")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all))
        }.environmentObject(usrData)
        
    }
    
    var namePick: some View {
        ZStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text("What's your name?")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .frame(width: 300, alignment: .leading)
                    .padding(.top)
                    .padding(.leading)
                
                TextField("Enter your name", text: $txtField)
                    .frame(width: 300)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 25.0)
                        .foregroundStyle(.white)
                        .opacity(0.5)
                    )
                //.padding(.leading)
                    .foregroundStyle(.black)
                    .onSubmit {
                        usrData.name = txtField
                        txtField = ""
                        withAnimation {
                            whichQn += 1
                        }
                    }
                
                Spacer()
            }.frame(width: 300, height: 150)
        }.padding(.top)
    }
    
    var recPick: some View {
        ZStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text("What are you recovering from?")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .frame(width: 300, alignment: .leading)
                    .padding(.top)
                    .padding(.leading)
                
                TextField("", text: $txtField)
                    .frame(width: 300)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 25.0)
                        .foregroundStyle(.white)
                        .opacity(0.5)
                    )
                //.padding(.leading)
                    .foregroundStyle(.black)
                    .onSubmit {
                        usrData.soberFrom = txtField
                        txtField = ""
                        withAnimation {
                            whichQn += 1
                        }
                    }
                
                Spacer()
            }.frame(width: 300, height: 150)
        }.padding(.top)
    }
    
    var fromPick: some View {
        ZStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text("When did your sobriety start?")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .frame(width: 300, alignment: .leading)
                    .padding(.top)
                //.padding(.leading)
                
                DatePicker(selection: $date, in: ...Date.now, displayedComponents: .date) {
                    Text("I've been sober since")
                        .foregroundStyle(.black)
                }
                .onChange(of: date) {
                    print("here")
                    let df = DateFormatter()
                    df.dateFormat = "yyyy-MM-dd"
                    usrData.soberSince = df.string(from: date)
                    withAnimation {
                        whichQn += 1
                    }
                }
                
                Spacer()
            }.frame(width: 300, height: 150)
        }.padding(.top)
    }
    
    var reasonPick: some View {
        ZStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text("What are your reasons \n for quitting?")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .frame(width: 300, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top)
                //.padding(.leading)
                
                TextField("", text: $txtField, axis: .vertical)
                    .frame(width: 300)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 25.0)
                        .foregroundStyle(.white)
                        .opacity(0.5)
                    )
                //.padding(.leading)
                    .foregroundStyle(.black)
                
                HStack {
                    Spacer()
                    Button("Next") {
                        usrData.reasonsQuit = txtField
                        txtField = ""
                        withAnimation {
                            whichQn += 1
                        }
                    }.frame(width: 100, alignment: .center)
                        .font(.title2)
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 25))
                        .foregroundStyle(.blue)
                    Spacer()
                }.padding(.top, 30)
                Spacer()
            }.frame(width: 300, height: 300)
        }.padding(.top)
    }
    
    var resourcePick: some View {
        ZStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text("How frequent was your use per week?")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .frame(width: 300, alignment: .leading)
                    .padding(.top)
                //.padding(.leading)
                
                HStack {
                    Slider(value: $freqWeek, in: 1...7, step: 1)
                    Text("\(Int(freqWeek))")
                }
                
                Text("How much did you spend per week?")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .frame(width: 300, alignment: .leading)
                    .padding(.top)
                //.padding(.leading)
                
                TextField("$", text: $txtField)
                    .frame(width: 300)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 25.0)
                        .foregroundStyle(.white)
                        .opacity(0.8)
                    )
                //.padding(.leading)
                    .foregroundStyle(.black)
               
                HStack {
                    NavigationLink("", destination: DashboardView(), isActive: $willMoveToNextScreen)
                    Spacer()
                    Button("Next") {
                        usrData.freqWeek = Int(freqWeek)
                        usrData.cost = Int(txtField) ?? 0
                        willMoveToNextScreen.toggle()
                    }.frame(width: 100, alignment: .center)
                        .font(.title2)
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 25))
                        .foregroundStyle(.blue)
                    Spacer()
                }.padding(.top, 30)
                
                
                Spacer()
            }.frame(width: 300, height: 500)
        }.padding(.top)
    }
}

#Preview {
    SetupView()
}
