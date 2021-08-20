//
//  StringFunctions.swift
//  StringFunctions
//
//  Created by Johnny on 13/8/2021.
//

import SwiftUI


extension String {
    //    var localized: String {
    //        return NSLocalizedString(self, comment:"")
    //    }
    
    public func localized() -> String {
        var result = ""
        if let path = Bundle.main.path(forResource: UserDefaults.standard.string(forKey: "lang"), ofType: "lproj"),
           let bundle = Bundle(path: path){
            result = bundle.localizedString(forKey: self, value: nil, table: nil)
        }
        return result
    }
    
}

extension String {
     
    //將原始的url編碼轉為合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
     
    //將編碼後的url轉換回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
}
