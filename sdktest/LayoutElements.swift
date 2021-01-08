//
//  LayoutElements.swift
//  sdktest
//
//  Created by Thomas Birke on 06.01.21.
//  Copyright © 2021 sdktestOrganizationName. All rights reserved.
//

import SwiftUI

struct circleCompleted: View {
    var body: some View {
        Image(systemName: "checkmark.circle.fill")
            .padding(.horizontal, 4.0)
            .font(.system(size: 12.0))
            .foregroundColor(Color("paleBlue"))
    }
}

struct circleActive: View {
    var body: some View {
        Circle()
            .frame(width: 12.0, height: 12.0)
            .foregroundColor(.white)
            .overlay(
                Circle()
                    .stroke(Color("VWlightBlue"), lineWidth: 4)
            )
            .padding(.horizontal, 4.0)
            
    }
}
struct circleInactive: View {
    var body: some View {
        Circle()
            .frame(width: 12.0, height: 12.0)
            .foregroundColor(Color("SalesforceGray"))
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: 4)
            )
            
    }
}

struct progressBar: View {
    let numberOfSteps: Int
    let activeStep: Int
    var body: some View {
        HStack(alignment: .center){
            ForEach((1...numberOfSteps), id: \.self){
                let last = $0 == numberOfSteps
                if(activeStep > $0){
                    circleCompleted()
                    last ? nil : Spacer().frame(height:2).background(Color("paleBlue"))
                } else if(activeStep == $0){
                    circleActive()
                    last ? nil : Spacer().frame(height:2).background(Color("SalesforceGray"))
                } else {
                    circleInactive()
                    last ? nil : Spacer().frame(height:2).background(Color("SalesforceGray"))
                }
            }
        }
        .padding(.horizontal)
    }
}

struct cardSectionTitle: View {
    let title: String
    var body: some View {
        HStack(alignment: .bottom){
            Text(title)
                .font(.custom("VWHead-Bold", size: 16))
                .foregroundColor(Color("SectionTitle"))
            Spacer()
            Text("now")
                .font(.custom("VWHead-Regular", size: 16))
                .foregroundColor(Color("SectionUpdateTimer"))
                .padding(.trailing, 5.0)
        }
    }
   
}

struct LayoutElements_Previews: PreviewProvider {
    static var previews: some View {
        progressBar(numberOfSteps: 6, activeStep: 2)
    }
}
