//
//  ButtonStyles.swift
//  sdktest
//
//  Created by Thomas Birke on 05.01.21.
//  Copyright © 2021 sdktestOrganizationName. All rights reserved.
//

import Foundation
import SwiftUI

struct VWbuttonMedium : ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color("VWlightBlue"))
            .padding()
            .cornerRadius(24.0)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 24.0)
                    .stroke(Color("VWlightBlue"), lineWidth: 2)
            )
            
    }
}

struct VWbuttonCardBottom : ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.custom("VWHead-Regular", size: 16))
            .foregroundColor(Color("VWlightBlue"))
            .background(Color.white)
    }
}
