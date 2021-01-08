//
//  RentalCarModel.swift
//  weConnectIdDias
//
//  Created by Thomas Birke on 07.01.21.
//  Copyright © 2021 sdktestOrganizationName. All rights reserved.
//

import Foundation
import SalesforceSDKCore
import Combine

struct RentalContract :  Identifiable, Decodable  {
    let id: UUID = UUID()
    let Id: String
    let ProductName: String?
    let LicensePlate: String?
    let kmIncluded: String?
    let Price: String?
}

struct RentalCarResponse: Decodable {
    var results: [RentalContract]
}


class RentalCarModel: ObservableObject {
    private var rentalContractCancellable: AnyCancellable?
    @Published var rentalContract: [RentalContract]
    
    init(rentalContract: [RentalContract] = []) {
        self.rentalContract = rentalContract
        fetchRentalContract()
    }
    
    func fetchRentalContract(){
        let requestBodyString = "{\"ContactId\" : \"0033X00002taIUQQA2\"}"
        let request = RestRequest(method: .POST, serviceHostType: .instance,
                       path: "apexrest/workshopappointment/rental",
                       queryParams: nil)
        request.endpoint =  "/services/"
        request.setCustomRequestBodyString(requestBodyString, contentType: "application/json")
        print("###################### >>>>>>>     request.body: ", request)
        rentalContractCancellable = RestClient.shared.publisher(for: request)
            .receive(on: RunLoop.main)
            .tryMap({ (response) -> Data in
                print("###################### >>>>>>>     response: ", try response.asJson())
                return response.asData()
            })
            .decode(type: RentalCarResponse.self, decoder: JSONDecoder())
            .map({ (record) -> [RentalContract] in
                print("###################### >>>>>>>     record.results: ", record.results)
                return record.results
            })
            .catch( { error in
                Just([
                    RentalContract(
                        Id: "ErrorId",
                        ProductName: "Error",
                        LicensePlate: "\(error)",
                        kmIncluded: "0",
                        Price: "0,00 €"
                    )]
                    )
            })
            .assign(to: \.rentalContract, on:self)
    }
}
