//
//  Bus_KMBDetail.swift
//  Bus_KMBDetail
//
//  Created by Johnny on 20/8/2021.
//

import SwiftUI


struct Bus_KMBDetail: View {
    @State var route:KMB
    @ObservedObject var bus_KMB:Bus_KMB
    @ObservedObject var favouriteRoutes: FavouriteRoutes
    
    @State var showAlert:Bool = false
    @State var alertText:String = "Loading..."
    
    func loadStations(){
        bus_KMB.retrieveStations(route: route.route, direction: route.bound, serviceType: route.serviceType)
    }
    
    var body: some View {
        
        ZStack{
            VStack{
                HStack{
                    Text(route.orig_tc)
                        .fontWeight(.heavy)
                    Text(" -> ")
                    Text(route.dest_tc)
                        .fontWeight(.heavy)
                    Spacer()
                }
                ScrollView{
                    VStack(spacing:20){
                        if !bus_KMB.route_stations.isEmpty{
                            ForEach(bus_KMB.route_stations,id:\.self){ station in
                                let details:[String:String] = ["stop":station.stop,
                                                               "route":route.route,
                                                               "serviceType":route.serviceType,
                                                               "dir":route.bound,
                                                               "stopName":station.name_tc,
                                                               "routeDest":route.dest_tc,
                                                               "routeOrig":route.orig_tc]
                                if route.route == station.route, route.bound == station.bound{
                                    HStack{
                                        Text(station.seq)
                                        Text(station.name_tc)
                                        Spacer()
                                        Image(systemName: favouriteRoutes.checkFavourite(category: "bus_kmb", details: details) ? "star.fill":"star")
                                            .onTapGesture {
                                                if favouriteRoutes.checkFavourite(category: "bus_kmb", details: details){
                                                    for route in favouriteRoutes.favouriteArray{
                                                        if route.details == details, route.category == "bus_kmb"{
                                                            favouriteRoutes.removeFavourite(id: route.favouriteID)
                                                        }
                                                    }
                                                }else{
                                                    if favouriteRoutes.favouriteArray.count == 5{
                                                        self.alertText = "Max favourite is 5 currently"
                                                        self.showAlert = true
                                                    }
                                                    else{
                                                    favouriteRoutes.saveFavourite(category: "bus_kmb", details: details)
                                                    }
                                                }
                                            }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding()

        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertText))
        }

        .onAppear {
            loadStations()
        }

        .navigationTitle(route.route)
    }
}
