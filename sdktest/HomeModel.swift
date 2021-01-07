//
//  HomeModel.swift
//  sdktest
//
//  Created by Thomas Birke on 02.01.21.
//  Copyright © 2021 sdktestOrganizationName. All rights reserved.
//

import Foundation
import SalesforceSDKCore
import Combine

struct WorkOrder :  Identifiable, Decodable  {
    let id: UUID = UUID()
    let Id: String
    let Subject: String?
    let Status: String?
    let StatusCategory: String?
    let AssetName: String?
    let AssetProductName: String?
    let ServiceAppointmentId: String?
    let ServiceAppointmentDueDate: String?
    
}

struct HomeResponse: Decodable {
    var results: [WorkOrder]
}


class HomeModel: ObservableObject {
    private var workOrdersCancellable: AnyCancellable?
    @Published var workOrders: [WorkOrder]
    
    init(workOrders: [WorkOrder] = []) {
        self.workOrders = workOrders
        fetchWorkOrders()
    }
    
    func fetchWorkOrders(){
        let requestBodyString = "{\"UserId\" : \"0053X00000CIGISQA5\"}"
        let request = RestRequest(method: .POST, serviceHostType: .instance,
                       path: "apexrest/workshopappointment/open",
                       queryParams: nil)
        request.endpoint =  "/services/"
        request.setCustomRequestBodyString(requestBodyString, contentType: "application/json")
        print("###################### >>>>>>>     request.body: ", request)
        workOrdersCancellable = RestClient.shared.publisher(for: request)
            .receive(on: RunLoop.main)
            .tryMap({ (response) -> Data in
                print("###################### >>>>>>>     response: ", try response.asJson())
                return response.asData()
            })
            .decode(type: HomeResponse.self, decoder: JSONDecoder())
            .map({ (record) -> [WorkOrder] in
                print("###################### >>>>>>>     record.records: ", record.results)
                return record.results
            })
            .catch( { error in
                Just([
                    WorkOrder(
                        Id: "FakeId",
                        Subject: "Inspection",
                        Status: "Error Status",
                        StatusCategory: "In Progress",
                        AssetName: "\(error)",
                        AssetProductName: "VW ID Buzz",
                        ServiceAppointmentId: "FakeSAId",
                        ServiceAppointmentDueDate: "18.01.2020"
                    )
                    ])
            })
            .assign(to: \.workOrders, on:self)
    }
}
