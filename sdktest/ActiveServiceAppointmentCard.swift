//
//  ActiveServiceAppointmentCard.swift
//  weConnectIdDias
//
//  Created by Thomas Birke on 07.01.21.
//  Copyright © 2021 sdktestOrganizationName. All rights reserved.
//

import SwiftUI

struct ActiveServiceAppointmentCard: View {
    @ObservedObject var viewModel = ActiveServiceAppointmentModel()
    
    var body: some View {
        VStack(){
            ForEach(viewModel.workOrders, id: \.id) { dataItem in
                VStack(
                    alignment: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, spacing: 10, content: {
                        cardSectionTitle(title: "Active Service Appointment")
                            
                        VStack(alignment: .leading, spacing: 10) {
                            ServiceAppointmentCardHeader(dataItem: dataItem)
                            StatusIndicator(StatusCategory: dataItem.StatusCategory ?? "unknown")
                            currentStatusStep(Status: dataItem.Status ?? "unknown")
                            progressBar(numberOfSteps: 6, activeStep: getStatusAsInt(status: dataItem.Status ?? "unknown")).padding(.horizontal, 4.0)
                            completionEstimate(DueDate: convertDateStringFromSalesforce(source: dataItem.ServiceAppointmentDueDate ?? "unknown"))
                            
                            NavigationLink(destination:ServiceAppointmentDetailView(serviceAppointmentId: dataItem.Id)){
                                
                                VStack(){
                                        Divider()
                                        Spacer()
                                        HStack(alignment: .center, spacing: nil, content: {
                                            Spacer()
                                            Text("Details")
                                            Spacer()
                                        })
                                        Spacer()
                                    }.frame(height: 48.0)
                                    
                                    
                                
                            }
                            
                        }
                        .background(Color.white)
                        .cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                        
                        .shadow(color: Color.black.opacity(0.05), radius: 12, x: 2, y: 2)
                        .shadow(color: Color.black.opacity(0.1), radius: 24, x: 4, y: 4)
                    }
                )
            }
        }
        .onAppear {
            self.viewModel.fetchWorkOrders()
        }
    }
}

struct completionEstimate: View {
    let DueDate: String
    var body: some View {
        HStack(alignment: .bottom){
            Text("Estimated Completion")
                .font(.custom("VWText-Regular", size: 14))
                .foregroundColor(Color("SectionTitle"))
            Spacer()
            Text("\(DueDate)")
                .font(.custom("VWText-Light", size: 14))
                .foregroundColor(Color("SectionUpdateTimer"))
                .padding(.trailing, 5.0)
        }.padding(.horizontal, 24.0)
    }
   
}


struct StatusIndicator: View {
    let StatusCategory: String
    var body: some View {
        HStack(alignment: .center) {
            switch StatusCategory {
                case "New":
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 12.0))
                        .foregroundColor(Color("Emerald"))
                    Text("scheduled").font(.custom("VWHead-Bold", size: 14))
                        .foregroundColor(Color("Emerald"))
                case "In Progress":
                    Image(systemName: "wrench.fill")
                        .font(.system(size: 12.0))
                        .foregroundColor(Color("Emerald"))
                    Text("in progress").font(.custom("VWHead-Bold", size: 14))
                        .foregroundColor(Color("Emerald"))
                default:
                    Text("unknown")
                }
            
        }
        .padding(.leading, 24.0)
    }
}

struct currentStatusStep: View {
    let Status: String
    
    var body: some View {
        HStack(alignment: .center) {
            switch Status {
                case "Scheduled":
                    Text("(1/6)").font(.custom("VWHead-Light", size: 14))
                        .foregroundColor(Color("CardSubHeader"))
                    Text("service appointment scheduled").font(.custom("VWHead-Light", size: 14))
                        .foregroundColor(Color("CardSubHeader"))
                case "vehicle onsite":
                    Text("(2/6)").font(.custom("VWHead-Light", size: 14))
                        .foregroundColor(Color("CardSubHeader"))
                    Text("vehicle on site").font(.custom("VWHead-Light", size: 14))
                        .foregroundColor(Color("CardSubHeader"))
                case "in Progress":
                    Text("(3/6)").font(.custom("VWHead-Light", size: 14))
                        .foregroundColor(Color("CardSubHeader"))
                    Text("service in progress").font(.custom("VWHead-Light", size: 14))
                        .foregroundColor(Color("CardSubHeader"))
                case "clean":
                    Text("(4/6)").font(.custom("VWHead-Light", size: 14))
                        .foregroundColor(Color("CardSubHeader"))
                    Text("finishing and cleaning").font(.custom("VWHead-Light", size: 14))
                        .foregroundColor(Color("CardSubHeader"))
                case "ready for pickup":
                    Text("(5/6)").font(.custom("VWHead-Light", size: 14))
                        .foregroundColor(Color("CardSubHeader"))
                    Text("ready for delivery").font(.custom("VWHead-Light", size: 14))
                        .foregroundColor(Color("CardSubHeader"))
                case "Completed":
                    Text("(6/6)").font(.custom("VWHead-Light", size: 14))
                        .foregroundColor(Color("CardSubHeader"))
                    Text("completed").font(.custom("VWHead-Light", size: 14))
                        .foregroundColor(Color("CardSubHeader"))
            default:
                    Text("unknown")
                }
            
        }
        .padding(.leading, 24.0)
    }
}

struct ServiceAppointmentCardHeader: View {
    @EnvironmentObject var show: ViewOptions
    
    let dataItem: WorkOrder
    var body: some View {
        HStack(alignment: .top){
            VehicleIconCircle()
            VStack(alignment: .leading){
                Text(dataItem.Subject ?? "SubjectMissing")
                    .font(.custom("VWHead-Light", size: 21))
                    .foregroundColor(Color("CardHeader"))
                Text(dataItem.AssetName ?? "AssetNameMissing")
                    .font(.custom("VWHead-Light", size: 15))
                    .foregroundColor(Color("CardSubHeader"))
                
            }
            Spacer()
            Button(action: {
                print("button pressed yo")
                show.showActiveServiceAppointment = false
            }) {
                Image(systemName: "xmark")
                    .font(.system(size: 16.0))
                    .foregroundColor(Color.gray)
            }
            
            
        }
        .padding([.top, .leading, .trailing])
    }
}

func convertDateStringFromSalesforce(source: String) -> String {
    var result = ""
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "de_DE") //
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
    let date = dateFormatter.date(from:source)!
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "dd.MM.yyyy, HH:mm"
    result = dateFormatterPrint.string(from: date)
    return result
}

func getStatusAsInt(status: String) -> Int {
    var activeItem = 0
    switch status {
        case "Scheduled":
            activeItem = 1
        case "vehicle onsite":
            activeItem = 2
        case "in Progress":
            activeItem = 3
        case "clean":
            activeItem = 4
        case "ready for pickup":
            activeItem = 5
        case "Completed":
            activeItem = 6
    default:
            activeItem = 1
        }
    return activeItem
}



struct ActiveServiceAppointmentCard_Previews: PreviewProvider {
    static var previews: some View {
        ActiveServiceAppointmentCard(viewModel: ActiveServiceAppointmentModel(workOrders:[
            WorkOrder(
                Id: "0WO3X000000SRrdWAG",
                Subject: "30'000 Inspection",
                Status: "vehicle onsite",
                StatusCategory: "In Progress",
                AssetName: "John's I.D. Buzz",
                AssetProductName: "VW ID Buzz 1st edition",
                ServiceAppointmentId: "08p3X0000005mAlQAI",
                ServiceAppointmentDueDate: "2021-01-05T09:30:00.000Z"
            )
        
        ]))
    }
}
