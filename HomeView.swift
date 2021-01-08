//
//  HomeView.swift
//  sdktest
//
//  Created by Thomas Birke on 02.01.21.
//  Copyright © 2021 sdktestOrganizationName. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import SalesforceSDKCore

struct HomeView: View {
    @EnvironmentObject var viewOptions: ViewOptions
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack{
                    Greeting()
                    if(viewOptions.showActiveServiceAppointment){
                        ActiveServiceAppointmentCard()
                            .padding(.bottom, 32.0)
                    }
                    RentalCarCard()
                        .padding(.bottom, 32.0)
                    VStack(){
                        cardSectionTitle(title: "Charge Level")
                        Image("fakeChargeLevelCard").background(Color.white)
                            .cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                            
                            .shadow(color: Color.black.opacity(0.05), radius: 12, x: 2, y: 2)
                            .shadow(color: Color.black.opacity(0.1), radius: 24, x: 4, y: 4)

                    }.padding(.bottom, 32.0)
                    Button(action: {showDetails()}) {
                        HStack{
                            Spacer()
                            Text("Edit homescreen")
                            Spacer()
                        }
                    }.padding([.leading, .trailing], 36.0).buttonStyle(VWbuttonMedium())
                    
                }
                .padding(.horizontal)
            }
        }
        
    }
    
}
func showDetails(){
    print("showDetails")
}



struct Greeting: View {
    var body: some View {
        VStack{
            HStack(){
                Text("Hello")
                    .font(.custom("VWHead-Bold", size: 32))
                    .foregroundColor(.black)
                Text("John")
                    .font(.custom("VWHead-Light", size: 32))
                    .foregroundColor(.black)
                Spacer()
            }
            HStack{
                Image(systemName: "arrow.clockwise")
                    .font(.system(size: 12.0))
                    .foregroundColor(Color("SectionUpdateTimer"))
                Text("now")
                    .font(.custom("VWHead-Regular", size: 12))
                    .foregroundColor(Color("SectionUpdateTimer"))
                Spacer()
            }
        }
        .padding(.bottom, 32.0)
        
    }
   
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
