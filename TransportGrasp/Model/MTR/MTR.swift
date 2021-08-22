//
//  MTR.swift
//  MTR
//
//  Created by Johnny on 21/8/2021.
//

import Foundation

struct MTR: Hashable, Codable, Identifiable {
    var id = UUID()
    
    var line:String
    var lineCode:String
    var station:String
    var stationCode:String
    //    var direction:String // up/ down
}

class MTR_Airport:Identifiable{
    var stations:[MTR] = [
        MTR(line: "Airport", lineCode:"AEL", station: "博覽館", stationCode: "AWE"),
        MTR(line: "Airport", lineCode:"AEL", station: "機場", stationCode: "AIR"),
        MTR(line: "Airport", lineCode:"AEL", station: "青衣", stationCode: "TSY"),
        MTR(line: "Airport", lineCode:"AEL", station: "九龍", stationCode: "KOW"),
        MTR(line: "Airport", lineCode:"AEL", station: "香港", stationCode: "HOK")
    ]
    
    var stationDict: [String:String] = ["AWE":"博覽館",
                                        "AIR":"機場",
                                        "TSY":"青衣",
                                        "KOW":"九龍",
                                        "HOK":"香港"]
}

class MTR_TungChung:Identifiable{
    var stations:[MTR] = [
        MTR(line: "TungChung", lineCode:"TCL", station: "東涌", stationCode: "TUC"),
        MTR(line: "TungChung", lineCode:"TCL", station: "欣澳", stationCode: "SUN"),
        MTR(line: "TungChung", lineCode:"TCL", station: "青衣", stationCode: "TSY"),
        MTR(line: "TungChung", lineCode:"TCL", station: "荔景", stationCode: "LAK"),
        MTR(line: "TungChung", lineCode:"TCL", station: "南昌", stationCode: "NAC"),
        MTR(line: "TungChung", lineCode:"TCL", station: "奧運", stationCode: "OLY"),
        MTR(line: "TungChung", lineCode:"TCL", station: "九龍", stationCode: "KOW"),
        MTR(line: "TungChung", lineCode:"TCL", station: "香港", stationCode: "HOK")
    ]
    
    var stationDict: [String:String] = ["TUC":"東涌",
                                        "SUN":"欣澳",
                                        "TSY":"青衣",
                                        "LAK":"荔景",
                                        "NAC":"南昌",
                                        "OLY":"奧運",
                                        "KOW":"九龍",
                                        "HOK":"香港"]
}

class MTR_TuenMa:Identifiable{
    var stations:[MTR] = [
        MTR(line: "TuenMa", lineCode: "TML", station: "屯門", stationCode: "TUM"),
        MTR(line: "TuenMa", lineCode: "TML", station: "兆康", stationCode: "SIH"),
        MTR(line: "TuenMa", lineCode: "TML", station: "天水圍", stationCode: "TIS"),
        MTR(line: "TuenMa", lineCode: "TML", station: "朗屏", stationCode: "LOP"),
        MTR(line: "TuenMa", lineCode: "TML", station: "元朗", stationCode: "YUL"),
        MTR(line: "TuenMa", lineCode: "TML", station: "錦上路", stationCode: "KSR"),
        MTR(line: "TuenMa", lineCode: "TML", station: "荃灣西", stationCode: "TWW"),
        MTR(line: "TuenMa", lineCode: "TML", station: "美孚", stationCode: "MEF"),
        MTR(line: "TuenMa", lineCode: "TML", station: "南昌", stationCode: "NAC"),
        MTR(line: "TuenMa", lineCode: "TML", station: "柯士甸", stationCode: "AUS"),
        MTR(line: "TuenMa", lineCode: "TML", station: "尖東", stationCode: "ETS"),
        MTR(line: "TuenMa", lineCode: "TML", station: "紅磡", stationCode: "HUH"),
        MTR(line: "TuenMa", lineCode: "TML", station: "何文田", stationCode: "HOM"),
        MTR(line: "TuenMa", lineCode: "TML", station: "土瓜灣", stationCode: "TKW"),
        MTR(line: "TuenMa", lineCode: "TML", station: "宋皇臺", stationCode: "SUW"),
        MTR(line: "TuenMa", lineCode: "TML", station: "啟德", stationCode: "KAT"),
        MTR(line: "TuenMa", lineCode: "TML", station: "鑽石山", stationCode: "DIH"),
        MTR(line: "TuenMa", lineCode: "TML", station: "顯徑", stationCode: "HIK"),
        MTR(line: "TuenMa", lineCode: "TML", station: "大圍", stationCode: "TAW"),
        MTR(line: "TuenMa", lineCode: "TML", station: "車公廟", stationCode: "CKT"),
        MTR(line: "TuenMa", lineCode: "TML", station: "沙田圍", stationCode: "STW"),
        MTR(line: "TuenMa", lineCode: "TML", station: "第一城", stationCode: "CIO"),
        MTR(line: "TuenMa", lineCode: "TML", station: "石門", stationCode: "SHM"),
        MTR(line: "TuenMa", lineCode: "TML", station: "大水坑", stationCode: "TSH"),
        MTR(line: "TuenMa", lineCode: "TML", station: "恒安", stationCode: "HEO"),
        MTR(line: "TuenMa", lineCode: "TML", station: "馬鞍山", stationCode: "MOS"),
        MTR(line: "TuenMa", lineCode: "TML", station: "烏溪沙", stationCode: "WKS")
    ]
    var stationDict: [String:String] = ["TUM":"屯門",
                                        "SIH":"兆康",
                                        "TIS":"天水圍",
                                        "LOP":"朗屏",
                                        "YUL":"元朗",
                                        "KSR":"錦上路",
                                        "TWW":"荃灣西",
                                        "MEF":"美孚",
                                        "NAC":"南昌",
                                        "AUS":"柯士甸",
                                        "ETS":"尖東",
                                        "HUH":"紅磡",
                                        "HOM":"何文田",
                                        "TKW":"土瓜灣",
                                        "SUW":"宋皇臺",
                                        "KAT":"啟德",
                                        "DIH":"鑽石山",
                                        "HIK":"顯徑",
                                        "TAW":"大圍",
                                        "CKT":"車公廟",
                                        "STW":"沙田圍",
                                        "CIO":"第一城",
                                        "SHM":"石門",
                                        "TSH":"大水坑",
                                        "HEO":"恒安",
                                        "MOS":"馬鞍山",
                                        "WKS":"烏溪沙"]
                              
}

class MTR_TKO:Identifiable{
    var stations:[MTR] = [
        MTR(line: "TKO", lineCode: "TKL", station: "寶琳", stationCode: "POA"),
        MTR(line: "TKO", lineCode: "TKL", station: "坑口", stationCode: "HAH"),
        MTR(line: "TKO", lineCode: "TKL", station: "康城", stationCode: "LHP"),
        MTR(line: "TKO", lineCode: "TKL", station: "將軍澳", stationCode: "TKO"),
        MTR(line: "TKO", lineCode: "TKL", station: "調景嶺", stationCode: "TIK"),
        MTR(line: "TKO", lineCode: "TKL", station: "油塘", stationCode: "YAT"),
        MTR(line: "TKO", lineCode: "TKL", station: "鰂魚涌", stationCode: "QUB"),
        MTR(line: "TKO", lineCode: "TKL", station: "北角", stationCode: "NOP")
    ]
    var stationDict: [String:String] = ["POA":"寶琳",
                                        "HAH":"坑口",
                                        "LHP":"康城",
                                        "TKO":"將軍澳",
                                        "TIK":"調景嶺",
                                        "YAT":"油塘",
                                        "QUB":"鰂魚涌",
                                        "NOP":"北角"]
}
