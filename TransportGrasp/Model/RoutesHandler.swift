//
//  RoutesHandler.swift
//  RoutesHandler
//
//  Created by Johnny on 20/8/2021.
//

import Foundation
import SwiftUI

class RoutesHandler{
    
    func getCategory(targetRoute:Favourite)->String{
        var resultString = ""
        switch targetRoute.category {
        case "bus_kmb":
            resultString = "KMB"
        case "mtr_tungChung":
            resultString = "東涌綫"
        case "mtr_tuenMa":
            resultString = "屯馬綫"
        case "mtr_airport":
            resultString = "機場快綫"
        case "mtr_TKO":
            resultString = "將軍澳綫"
        default:
            resultString = ""
        }
        return resultString
    }
    
    func getCatrgoryColor(targetRoute:Favourite) -> Color{
        switch targetRoute.category {
        case "bus_kmb":
            return Color.init("kmbRed")
        case "mtr_tungChung":
            return Color.init("mtrTungChung")
        case "mtr_tuenMa":
            return Color.init("mtrTuenMa")
        case "mtr_airport":
            return Color.init("mtrAirport")
        case "mtr_TKO":
            return Color.init("mtrTKO")
        default:
            return Color.primary
        }
    }
    
    func getTitle(targetRoute:Favourite) -> String{
        var resultString = ""
                
        if targetRoute.category == "bus_kmb",
           let route = targetRoute.details["route"],
           let orig = targetRoute.details["routeOrig"],
           let dest = targetRoute.details["routeDest"]{
            resultString = "\(route) \(orig) -> \(dest)"
        }
        else if targetRoute.category.contains("mtr"),
                let destStation = targetRoute.details["dest"],
                let line = targetRoute.details["line"],
                let origStation = targetRoute.details["orig"]{
            resultString = "\(origStation)->\(destStation)"
        }
        
                
        return resultString
    }
    
    func getStationName(targetRoute:Favourite) -> String{
        var resultString = ""
        if targetRoute.category == "bus_kmb",
           let stopName = targetRoute.details["stopName"]{
            resultString = "\(stopName)"
        }
        else if targetRoute.category.contains("mtr"),
                let station = targetRoute.details["station"]{
            resultString = "\(station)"
        }
        resultString += "站"
        return resultString
    }

    
//    func getIntervals(favourite:Favourite) -> [String]{
//        var resultString:[String] = []
//        if favourite.category == "bus_kmb",
//
//            resultString = Bus_KMB().getIntervalString(stop_id: stop_id, route: route, service_type: service_type, dir: dir)
//            print("result: \(resultString)")
//        }
//        
//        return resultString
//    }

    
}
