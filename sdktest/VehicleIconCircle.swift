//
//  VehicleIconCircle.swift
//  sdktest
//
//  Created by Thomas Birke on 05.01.21.
//  Copyright © 2021 sdktestOrganizationName. All rights reserved.
//

import SwiftUI

struct VehicleIconCircle: View {
    var body: some View {
        Image("ID.Buzz.1st")
            .resizable()
            .frame(width: 96.0, height: 96.0)
            .offset(x:8.0)
            .frame(width: 48.0, height: 48.0)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .shadow(color: Color.black.opacity(0.2), radius:4, x: 3, y: 3 )
    }
}

struct VehicleIconCircle_Previews: PreviewProvider {
    static var previews: some View {
        VehicleIconCircle()
    }
}
