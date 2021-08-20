//
//  SharedOptions.swift
//  amplifyDemo
//
//  Created by Johnny on 28/6/2021.
//

import Foundation

class SharedOptions: ObservableObject {
    @Published var loggined = false
    @Published var loading: Bool = false
        
    func startLoading(){
        self.loading = true
    }
    func finishedLoading(){
        self.loading = false
    }
    
}
