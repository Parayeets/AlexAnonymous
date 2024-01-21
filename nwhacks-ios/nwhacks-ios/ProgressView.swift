//
//  ProgressView.swift
//  nwhacks-ios
//
//  Created by Robin on 21/1/24.
//

import SwiftUI

struct ProgressView: View {
    
    @EnvironmentObject var usrData: UserData
    //@ObservedObject var usrData = UserData()
    
    var body: some View {
        //ScrollView {
        ZStack {
            Color(red: 134/255, green: 195/255, blue: 205/255)
                .ignoresSafeArea()
            VStack {
                VStack(alignment: .leading) {
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Hey \(usrData.name)!")
                                .font(.title)
                                .fontWeight(.heavy)
                                .padding(.leading)
                                .padding(.top, 20)
                                .foregroundStyle(.black)
                            Text("You've been sober for")
                                .padding(.leading)
                                .padding(.top, 1)
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                            
                            Text("\(dateDifference(currentDate: Date(), dateString: usrData.soberSince)[0]) years")
                                .padding(.leading)
                                .padding(.top)
                                .font(.largeTitle)
                                .foregroundStyle(.black)
                            Text("\(dateDifference(currentDate: Date(), dateString: usrData.soberSince)[1]) months")
                                .padding(.leading)
                                .font(.largeTitle)
                                .foregroundStyle(.black)
                            Text("\(dateDifference(currentDate: Date(), dateString: usrData.soberSince)[2]) days")
                                .padding(.leading)
                                .font(.largeTitle)
                                .padding(.bottom, 30)
                                .foregroundStyle(.black)
                            
                            let cost = usrData.cost * usrData.freqWeek * ((daysSinceDateString(usrData.soberSince) ?? 0) / 7)
                            Text("You've saved $\(cost)")
                                .padding(.leading)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .padding(.bottom, 30)
                                .foregroundStyle(.black)
                            
                        }
                        Spacer()
                        Image("girl")
                            .resizable()
                            .frame(width: 125, height: 150)
                        Spacer()
                    }
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 35.0)
                        .frame(maxHeight: .infinity)
                        .foregroundStyle(.white)
                        .edgesIgnoringSafeArea(.bottom)
                    
                    VStack(alignment: .leading) {
                        Text("Milestones")
                            .fontWeight(.heavy)
                            .font(.title2)
                        ScrollView(.horizontal) {
                            
                            HStack {
                                if dateDifference(currentDate: Date(), dateString: usrData.soberSince)[1] < 1 {
                                    Text("You are \(30 - dateDifference(currentDate: Date(), dateString: usrData.soberSince)[2]) days away from your first month sober!")
                                } else {
                                    ForEach(1...dateDifference(currentDate: Date(), dateString: usrData.soberSince)[1], id: \.self) { index in
                                        Image("M\(index)")
                                            .resizable()
                                            .frame(width: 80, height: 100)
                                    }
                                }
                            }
                        }
                        
                        Text("Your reasons for staying sober")
                            .fontWeight(.heavy)
                            .font(.title2)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top, 30)
                        
                        ScrollView {
                            Text("\(usrData.reasonsQuit)")
                                .padding(.top)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(height: 200)
                        }
                        
                    }.frame(width: 300, height: 350)
                        .padding(25)
                }.frame(alignment: .top)
                
                Spacer()
            }.edgesIgnoringSafeArea(.bottom)
        }
        
    }
}

#Preview {
    ProgressView()
}
