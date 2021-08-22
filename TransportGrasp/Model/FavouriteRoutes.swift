//
//  FavouriteRoutes.swift
//  FavouriteRoutes
//
//  Created by Johnny on 20/8/2021.
//

import Foundation
import SwiftUI
import Intents

import Alamofire
import SwiftyJSON

struct Favourite: Hashable, Codable, Identifiable{
    var id = UUID()
    
    var favouriteID:Int
    var category:String
    var details:[String:String]
    var eta:[String]
}
class FavouriteRoutes:ObservableObject,Identifiable{
    @AppStorage("favourites",store: UserDefaults(suiteName: "group.com.johnnyip.TransportGrasp"))
    var favouriteData:Data = Data()
    
    @Published var favouriteArray:[Favourite] = []
    
    init(){
        retrieveFavourite()
        donateSiriSuggestion()
    }
    
    func donateSiriSuggestion(){
        let intent = ETAIntent()
        intent.suggestedInvocationPhrase = "Get ETA of public transport"
        
        let interaction = INInteraction(intent: intent, response: nil)
        
        interaction.donate { error in
            if let error = error as NSError? {
                print("Interaction donation failed: \(error.description).")
            } else {
                print("Successfully donated interaction.")
            }
        }

    }
    
    func checkFavourite(category:String, details:[String:String]) -> Bool{
        for favourite in favouriteArray{
            if favourite.category == category, favourite.details == details{
                return true
            }
        }
        return false
    }
    
    func retrieveFavourite(){
        guard let favouriteArray_ = try? JSONDecoder().decode([Favourite].self, from: favouriteData) else {return}
        self.favouriteArray = favouriteArray_
    }
    
    func saveFavourite(category:String, details:[String:String]){
        
        let favouirteItem = Favourite(favouriteID: favouriteArray.count+1, category: category, details: details,eta: [])
        favouriteArray.append(favouirteItem)
        
        guard let favouriteData_ = try? JSONEncoder().encode(favouriteArray) else {return}
        self.favouriteData = favouriteData_
    }
    
    func removeFavourite(id:Int){
        for (index,route) in favouriteArray.enumerated(){
            if route.favouriteID == id{
                favouriteArray.remove(at: index)
            }
        }
        for (index,route) in favouriteArray.enumerated(){
            favouriteArray[index].favouriteID = index + 1
        }
        guard let favouriteData_ = try? JSONEncoder().encode(favouriteArray) else {return}
        self.favouriteData = favouriteData_
    }
    
    func updateETA(){
        for (index,route) in favouriteArray.enumerated(){
            if route.category == "bus_kmb"{
                eta_bus_kmb(index: index, favourite: route)
            }else if route.category.contains("mtr"){
                eta_mtr(index: index, favourite: route)
            }

            
            //            favouriteArray[index].eta = RoutesHandler().getIntervals(favourite: route)
        }
    }
    
    func eta_mtr(index:Int,favourite:Favourite){
        var tempETA:[String] = []
        if let lineCode = favourite.details["lineCode"],
           let stationCode = favourite.details["stationCode"],
           let dir = favourite.details["dir"]{
            
            let request = AF.request("https://rt.data.gov.hk/v1/transport/mtr/getSchedule.php?line=\(lineCode)&sta=\(stationCode)&lang=TC")
            request.responseJSON { response in
                switch response.result{
                case .success(let _data):
                    print("result get")
                    //setting header
                    print("dir: \(dir)")
                    
                    let json = JSON(_data)
                    if json["isdelay"] == "Y"{
                        tempETA.append("班次有延誤")
                    }
                    
                    print("data \(json)")
                    json["data"]["\(lineCode)-\(stationCode)"][dir].arrayValue.map{
                        print("value: \($0)")
                        var tempResultString = ""
                        let time = $0["time"].stringValue
                        var etaMins = ""
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        if let date_ = dateFormatter.date(from: time){
                            let cal = Calendar.current.dateComponents([.minute], from: Date(), to: date_)
                            if let minutes = cal.minute{
                                etaMins = "\(minutes) mins"
                            }
                        }
                            tempResultString += "\(etaMins)"
                            tempETA.append(tempResultString)
                    }
                    print("final ETA \(tempETA)")
                    self.favouriteArray[index].eta = tempETA
                default:
                    break;
                }
            }
        }
    }
    
    func eta_bus_kmb(index:Int,favourite:Favourite){
        var tempETA:[String] = []
        if let stop_id = favourite.details["stop"],
           let route = favourite.details["route"],
           let service_type = favourite.details["serviceType"],
           let dir = favourite.details["dir"]{
            
            let request = AF.request("https://data.etabus.gov.hk/v1/transport/kmb/eta/\(stop_id)/\(route)/\(service_type)")
            request.responseJSON { response in
                switch response.result{
                case .success(let _data):
                    print("result get")
                    //setting header
                    print("dir: \(dir)")
                    
                    let json = JSON(_data)
                    json["data"].arrayValue.map{
                        var tempResultString = ""
                        let eta = $0["eta"].stringValue
                        let dir_ = $0["dir"].stringValue
                        let remarks = $0["rmk_tc"].stringValue
                        var etaMins = ""
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
                        if let date_ = dateFormatter.date(from: eta){
                            let cal = Calendar.current.dateComponents([.minute], from: Date(), to: date_)
                            if let minutes = cal.minute{
                                etaMins = "\(minutes) mins"
                            }
                        }
                        if dir == dir_{
                            tempResultString += "\(etaMins)"
                            if remarks == "原定班次" {tempResultString += "(預計)"}
                            else if remarks != "" { tempResultString += " \(remarks)" }
                            tempETA.append(tempResultString)
                        }
                    }
                    print("final ETA \(tempETA)")
                    self.favouriteArray[index].eta = tempETA
                default:
                    break;
                }
            }
        }
    }
    
}

