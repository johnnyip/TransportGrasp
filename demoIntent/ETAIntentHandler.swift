//
//  ETAIntentHandler.swift
//  ETAIntentHandler
//
//  Created by Johnny on 20/8/2021.
//

import SwiftUI
import Intents
import Alamofire
import SwiftyJSON


struct Favourite: Hashable, Codable, Identifiable{
    var id = UUID()
    
    var favouriteID:Int
    var category:String
    var details:[String:String]
}


class ETAIntentHandler: NSObject, ETAIntentHandling{
    
    @AppStorage("favourites",store: UserDefaults(suiteName: "group.com.johnnyip.TransportGrasp"))
    var favouriteData:Data = Data()
    
    func getIntervals(dateString:String) -> String{
        var resultString = ""
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        if let result_ = dateFormatter.date(from: dateString){
            let cal = Calendar.current.dateComponents([.minute], from: Date(), to: result_)
            if let minutes = cal.minute{
                resultString = "\(minutes) 分鐘"
            }
        }
        return resultString
    }
    
    func resolveRoutes(for intent: ETAIntent, with completion: @escaping (RoutesResolutionResult) -> Void) {
        print("intent.Routes.rawValue \(intent.Routes.rawValue)")
        switch intent.Routes.rawValue {
        case 1:
            completion(RoutesResolutionResult.success(with: .route1))
        case 2:
            completion(RoutesResolutionResult.success(with: .route2))
        case 3:
            completion(RoutesResolutionResult.success(with: .route3))
        case 4:
            completion(RoutesResolutionResult.success(with: .route4))
        case 5:
            completion(RoutesResolutionResult.success(with: .route5))
        default:
            completion(RoutesResolutionResult.success(with: .route1))
        }
    }
    
    func handle(intent: ETAIntent, completion: @escaping (ETAIntentResponse) -> Void) {
        var resultString = ""
        var targetFavourite:Favourite = Favourite(favouriteID: 0, category: "", details: [:])
        guard let favouriteArray = try? JSONDecoder().decode([Favourite].self, from: favouriteData) else {return}
        //        for favourite in favouriteArray{
        //            targetFavourite = favourite
        //        }
        if intent.Routes.rawValue <= favouriteArray.count, !favouriteArray.isEmpty{
            targetFavourite = favouriteArray[intent.Routes.rawValue-1]
            print("intent.Routes.rawValue \(intent.Routes.rawValue)")
            print("favouriteArray.count \(favouriteArray.count)")
            
            if !favouriteArray.isEmpty,targetFavourite.favouriteID != 0{
                
                if targetFavourite.category == "bus_kmb",
                   let stop_id = targetFavourite.details["stop"],
                   let route = targetFavourite.details["route"],
                   let service_type = targetFavourite.details["serviceType"],
                   let dir = targetFavourite.details["dir"],
                   let stopName = targetFavourite.details["stopName"],
                   let routeDest = targetFavourite.details["routeDest"],
                   let routeOrig = targetFavourite.details["routeOrig"]{
                    
                    let request = AF.request("https://data.etabus.gov.hk/v1/transport/kmb/eta/\(stop_id)/\(route)/\(service_type)")
                    request.responseJSON { response in
                        switch response.result{
                        case .success(let _data):
                            print("result get")
                            //setting header
                            resultString += "[\(route)] \(routeOrig) -> \(routeDest)\n\(stopName)站\n\n"
                            
                            let json = JSON(_data)
                            json["data"].arrayValue.map{
                                let eta = $0["eta"].stringValue
                                let dir_ = $0["dir"].stringValue
                                let remarks = $0["rmk_tc"].stringValue
                                var etaMins = ""
                                

                                if dir == dir_{
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
                                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
                                    if let result_ = dateFormatter.date(from: eta){
                                        let cal = Calendar.current.dateComponents([.minute], from: Date(), to: result_)
                                        if let minutes = cal.minute{
                                            etaMins += "\(minutes) 分鐘"
                                        }
                                    }
                                    resultString += etaMins
                                    if remarks == "原定班次" {resultString += "(預計)\n"}
                                    else if remarks != "" { resultString += " \(remarks)\n" }
                                    else{ resultString += "\n" }
                                }
                            }
                            completion(.success(eta: resultString))
                        default:
                            break;
                        }
                    }
                }
                
                if targetFavourite.category.contains("mtr"),
                   let lineCode = targetFavourite.details["lineCode"],
                   let stationCode = targetFavourite.details["stationCode"],
                   let dir = targetFavourite.details["dir"],
                   let destStation = targetFavourite.details["dest"],
                   let line = targetFavourite.details["line"],
                   let origStation = targetFavourite.details["orig"],
                   let station = targetFavourite.details["station"]{
               
                    
                    let request = AF.request("https://rt.data.gov.hk/v1/transport/mtr/getSchedule.php?line=\(lineCode)&sta=\(stationCode)&lang=TC")
                    request.responseJSON { response in
                        switch response.result{
                        case .success(let _data):
                            print("result get")
                            //setting header
                            resultString = "[\(line)]\(origStation)->\(destStation)\n\(station)站\n\n"
                            print("dir: \(dir)")
                            
                            let json = JSON(_data)
                            if json["isdelay"] == "Y"{
                                resultString += "班次有延誤"
                            }
                            
                            print("data \(json)")
                            json["data"]["\(lineCode)-\(stationCode)"][dir].arrayValue.map{
                                print("value: \($0)")
                                let time = $0["time"].stringValue
                                var etaMins = ""
                                
                                let dateFormatter = DateFormatter()
                                dateFormatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
                                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                if let date_ = dateFormatter.date(from: time){
                                    let cal = Calendar.current.dateComponents([.minute], from: Date(), to: date_)
                                    if let minutes = cal.minute{
                                        etaMins = "\(minutes) 分鐘"
                                    }
                                }
                                resultString += "\(etaMins)\n"
                            }
                            completion(.success(eta: resultString))
                        default:
                            break;
                        }
                    }
                }
                
            }else{
                completion(.success(eta: "Error"))
            }
        }
        else{
            completion(.success(eta: "Error"))
            
        }
    }
    
    
}
