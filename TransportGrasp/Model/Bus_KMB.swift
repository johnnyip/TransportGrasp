//
//  bus_KMBModel.swift
//  bus_KMBModel
//
//  Created by Johnny on 20/8/2021.
//

import Foundation
import Alamofire
import SwiftyJSON


struct KMB: Hashable, Codable, Identifiable {
    var id = UUID()
    var route:String
    var bound:String
    var serviceType:String
    var dest_en:String
    var dest_tc:String
    var orig_en:String
    var orig_tc:String
}

struct KMB_routeStation:Hashable,Codable,Identifiable{
    var id = UUID()
    
    var route:String
    var bound:String
    var serviceType:String
    var seq:String
    var stop:String
    
    var name_tc:String
    var name_en:String
    var lat:String
    var long:String
    
}


class Bus_KMB:ObservableObject,Identifiable{
    
    @Published var routes:[KMB] = []
    @Published var route_stations:[KMB_routeStation] = []
    
    init(){
        retrieveRoutes()
    }
    
    func retrieveRoutes(){
        let request = AF.request("https://data.etabus.gov.hk/v1/transport/kmb/route/")
        request.responseJSON { response in
            
            switch response.result{
            case .success(let _data):
                //                print(_data)
                let json = JSON(_data)
                let result = json["data"].arrayValue.map{
                    let bound = $0["bound"].stringValue
                    let serviceType = $0["service_type"].stringValue
                    let dest_en = $0["dest_en"].stringValue
                    let dest_tc = $0["dest_tc"].stringValue
                    let orig_en = $0["orig_en"].stringValue
                    let orig_tc = $0["orig_tc"].stringValue
                    let route = $0["route"].stringValue
                    let kmb = KMB(route: route, bound: bound,serviceType: serviceType, dest_en: dest_en, dest_tc: dest_tc, orig_en: orig_en, orig_tc: orig_tc)
                    self.routes.append(kmb)
                    
                }
                
            default:
                break;
                
            }
        }
    }
    
    func retrieveStations(route:String, direction:String, serviceType:String){
        self.route_stations = []
        var direction_ = ""
        if direction == "I" { direction_ = "inbound"}
        else if direction == "O" {direction_ = "outbound"}
        let request = AF.request("https://data.etabus.gov.hk/v1/transport/kmb/route-stop/\(route)/\(direction_)/\(serviceType)")
        print("url: https://data.etabus.gov.hk/v1/transport/kmb/route-stop/\(route)/\(direction_)/\(serviceType)")
        request.responseJSON { response in
            switch response.result{
            case .success(let _data):
                let json = JSON(_data)
                let _ = json["data"].arrayValue.map{
                    let serviceType = $0["service_type"].stringValue
                    let route = $0["route"].stringValue
                    let bound = $0["bound"].stringValue
                    let seq = $0["seq"].stringValue
                    let stop = $0["stop"].stringValue
                    
                    let station = KMB_routeStation(route: route, bound: bound, serviceType: serviceType, seq: seq, stop: stop,name_tc: "", name_en: "",lat: "",long: "")
                    self.route_stations.append(station)
                }
                self.retrieveStationDetail()
            default:
                break;
                
            }
        }
        
    }
    
    func retrieveStationDetail(){
        for (index, station) in self.route_stations.enumerated() {
            //Get station info
            let request = AF.request("https://data.etabus.gov.hk/v1/transport/kmb/stop/\(station.stop)")
            request.responseJSON { response in
                switch response.result{
                case .success(let _data):
                    let json = JSON(_data)
                    let name_tc = json["data"]["name_tc"].stringValue
                    let name_en = json["data"]["name_en"].stringValue
                    let lat = json["data"]["lat"].stringValue
                    let long = json["data"]["long"].stringValue
                    
                    self.route_stations[index].name_tc = name_tc
                    self.route_stations[index].name_en = name_en
                    self.route_stations[index].lat = lat
                    self.route_stations[index].long = long
                    
                    
                default:
                    break;
                }
            }
            
        }
        
    }
    
//    func getIntervalString(stop_id:String,route:String,service_type:String,dir:String) -> [String]{
//        var resultString:[String] = []
//            let request = AF.request("https://data.etabus.gov.hk/v1/transport/kmb/eta/\(stop_id)/\(route)/\(service_type)")
//            request.responseJSON { response in
//                switch response.result{
//                case .success(let _data):
//                    print("result get")
//                    //setting header
//                    print("dir: \(dir)")
//                    
//                    let json = JSON(_data)
//                    json["data"].arrayValue.map{
//                        var tempResultString = ""
//                        let eta = $0["eta"].stringValue
//                        let dir_ = $0["dir"].stringValue
//                        let remarks = $0["rmk_tc"].stringValue
//                        var etaMins = ""
//                        
//                        let dateFormatter = DateFormatter()
//                        dateFormatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
//                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
//                        if let date_ = dateFormatter.date(from: eta){
//                            let cal = Calendar.current.dateComponents([.minute], from: Date(), to: date_)
//                            if let minutes = cal.minute{
//                                etaMins = "\(minutes) mins"
//                            }
//                        }
//                        if dir == dir_{
//                            tempResultString += "\(etaMins)"
//                            if remarks != "" { tempResultString += " \(remarks)\n" }
//                            else{ tempResultString += "\n" }
//                            resultString.append(tempResultString)
//                        }
//                    }
//                    print("Retrieved1: \(resultString)")
//                    return resultString;
//                default:
//                    break;
//                }
//            }
//        
//        return [];
//
//    }
    
}
