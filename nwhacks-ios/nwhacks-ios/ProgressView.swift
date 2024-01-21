//
//  ProgressView.swift
//  nwhacks-ios
//
//  Created by Robin on 21/1/24.
//

import SwiftUI

struct ProgressView: View {
    
    //@EnvironmentObject var usrData: UserData
    @ObservedObject var usrData = UserData()
    
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
                
                ZStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 35.0)
                        .frame(maxHeight: .infinity)
                        .foregroundStyle(.white)
                    .edgesIgnoringSafeArea(.bottom)
                    
                    ScrollView(.horizontal) {
                        ForEach(1...dateDifference(currentDate: Date(), dateString: usrData.soberSince)[2], id: \.self) { index in
                            
                        }
                        
                    }.frame(width: 300, height: 200)
                }.frame(alignment: .top)
                Spacer()
            }.edgesIgnoringSafeArea(.bottom)
        }
        
    }
    //}
}

#Preview {
    ProgressView()
}
