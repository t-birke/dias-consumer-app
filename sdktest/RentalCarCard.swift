//
//  RentalCarCard.swift
//  weConnectIdDias
//
//  Created by Thomas Birke on 07.01.21.
//  Copyright © 2021 sdktestOrganizationName. All rights reserved.
//

import SwiftUI

struct RentalCarCard: View {
    @ObservedObject var viewModel = RentalCarModel()
    
    var body: some View {
        VStack(){
            ForEach(viewModel.rentalContract, id: \.id) { dataItem in
                VStack(
                    alignment: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, spacing: 10, content: {
                        cardSectionTitle(title: "Rental Car")
                        VStack(alignment: .leading, spacing: 10) {
                            
                            //add card details
                            RentalCarBaseInfo(rc: dataItem)
                            
                            Button(action: {showDetails()}) {
                                VStack(){
                                    Divider()
                                        .padding(.bottom, 0.0)
                                    Spacer()
                                    HStack(alignment: .center, spacing: nil, content: {
                                        Spacer()
                                        Text("Details")
                                        Spacer()
                                    })
                                    Spacer()
                                }.frame(height: 48.0)
                                
                                
                            }.buttonStyle(VWbuttonCardBottom())
                        }.background(Color.white)
                        .cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                        
                        .shadow(color: Color.black.opacity(0.05), radius: 12, x: 2, y: 2)
                        .shadow(color: Color.black.opacity(0.1), radius: 24, x: 4, y: 4)
                    })
                    
        }
        }.onAppear {
        self.viewModel.fetchRentalContract()
    }
}
}

struct RentalCarBaseInfo: View {
    let rc: RentalContract
    
    var body: some View {
        HStack(alignment: .center){
            Spacer()
            VStack{
                if(rc.ProductName == "VW Touareg V8 R-Line"){
                    Image("Touareg").resizable()
                        .frame(width: 124.0, height: 53.0)
                } else if(rc.ProductName == "VW e-up!") {
                    Image("eUp").resizable()
                        .frame(width: 124.0, height: 71.0)
                }
                
            }
            Spacer()
            VStack(alignment: .leading){
                Text(rc.ProductName ?? "unknown product")
                    .font(.custom("VWHead-Bold", size: 12))
                    .foregroundColor(Color("CardHeader"))
                HStack{
                    VStack(alignment: .leading){
                        Text("license plate")
                            .font(.custom("VWHead-Regular", size: 12))
                            .foregroundColor(Color("CardHeader"))
                            .padding(.top, 4.0)
                        Text("km included")
                            .font(.custom("VWHead-Regular", size: 12))
                            .foregroundColor(Color("CardHeader"))
                            .padding(.top, 4.0)
                        Text("Cost per day")
                            .font(.custom("VWHead-Regular", size: 12))
                            .foregroundColor(Color("CardHeader"))
                            .padding(.top, 4.0)
                    }
                    VStack(alignment: .leading){
                        Text(rc.LicensePlate ?? "unknown")
                            .font(.custom("VWHead-Light", size: 12))
                            .foregroundColor(Color("CardHeader"))
                            .padding(.top, 4.0)
                        Text(rc.kmIncluded ?? "0")
                            .font(.custom("VWHead-Light", size: 12))
                            .foregroundColor(Color("CardHeader"))
                            .padding(.top, 4.0)
                        Text(rc.Price ?? "0.0" + " €")
                            .font(.custom("VWHead-Light", size: 12))
                            .foregroundColor(Color("CardHeader"))
                            .padding(.top, 4.0)
                    }
                }
            }
            Spacer()
        }
        .padding(.vertical)    }
}

struct RentalCarCard_Previews: PreviewProvider {
    static var previews: some View {
        RentalCarCard(viewModel: RentalCarModel(rentalContract: [
                        RentalContract(
                            Id: "blabla",
                            ProductName: "Touareg R-Line",
                            LicensePlate: "WOB T 3320",
                            kmIncluded: "100",
                            Price: "29,00€"
                        )]))
    }
}
