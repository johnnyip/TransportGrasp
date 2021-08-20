//
//  RoutesHandler.swift
//  RoutesHandler
//
//  Created by Johnny on 20/8/2021.
//

import Foundation

class RoutesHandler{
    
    func getCategory(targetRoute:Favourite)->String{
        var resultString = ""
        if targetRoute.category == "bus_kmb"{
            resultString = "KMB"
        }
        return resultString
    }
    
    func getTitle(targetRoute:Favourite) -> String{
        var resultString = ""
        
        if targetRoute.category == "bus_kmb",
           let route = targetRoute.details["route"],
           let orig = targetRoute.details["routeOrig"],
           let dest = targetRoute.details["routeDest"]{
            resultString = "\(route) \(orig) -> \(dest)"
        }
        return resultString
    }
    
    func getStationName(targetRoute:Favourite) -> String{
        var resultString = ""
        if targetRoute.category == "bus_kmb",
           let stopName = targetRoute.details["stopName"]{
            resultString = "\(stopName)"
        }
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
