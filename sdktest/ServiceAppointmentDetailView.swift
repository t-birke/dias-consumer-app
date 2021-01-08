//
//  ServiceAppointmentDetailView.swift
//  weConnectIdDias
//
//  Created by Thomas Birke on 08.01.21.
//  Copyright © 2021 sdktestOrganizationName. All rights reserved.
//

import SwiftUI

struct ServiceAppointmentDetailView: View {
    var serviceAppointmentId: String
    
    var body: some View {
        Text("ID = " + serviceAppointmentId)
    }
}

struct ServiceAppointmentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceAppointmentDetailView(serviceAppointmentId: "someId")
    }
}
