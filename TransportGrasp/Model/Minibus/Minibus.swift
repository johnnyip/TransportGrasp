//
//  Minibus.swift
//  Minibus
//
//  Created by Johnny on 22/8/2021.
//

import Foundation

struct Minibus_route: Hashable, Codable, Identifiable {
    var id = UUID()
    
    var routeID:String
    var description:String
    var station:String
    var stationCode:String
    //    var direction:String // up/ down
}

struct Minibus_routeNumber: Hashable, Codable, Identifiable {
    var id = UUID()
    
}

//class MTR_Airport:Identifiable{
//}
