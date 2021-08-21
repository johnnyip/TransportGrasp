//
//  ContentView.swift
//  TransportGrasp
//
//  Created by Johnny on 19/8/2021.
//

import SwiftUI
import Intents

struct Home: View {
    
    @ObservedObject var favouriteRoutes = FavouriteRoutes()
    @ObservedObject var sharedOptions = SharedOptions()
    
    @State var tabSelection:Int = 1
    
    var body: some View {
        ZStack{
            
            TabView(selection:$tabSelection){
                SummaryView(favouriteRoutes: self.favouriteRoutes)
                    .tabItem({
                        Image(systemName: "house.fill")
                        Text("Summary")
                    })
                    .tag(0)
                
                Add(favouriteRoutes: self.favouriteRoutes,sharedOptions: self.sharedOptions)
                    .tabItem({
                        Image(systemName: "plus")
                        Text("Add")
                    })
                    .tag(1)
            }
            .onAppear {
                if !favouriteRoutes.favouriteArray.isEmpty{
                    self.tabSelection = 0
                }
                INPreferences.requestSiriAuthorization { status in
                    switch status{
                    case .notDetermined,
                            .restricted,
                            .denied:
                        print("Siri error")
                    case .authorized:
                        print("Siri okay")
                    }
                }
                
                
                
            }
            if sharedOptions.loading {
                LoadingView()
            }
            
        }
        
        
        
        
        //        Text("Hello, world!")
        //            .padding()
        //            .hidden()
        
    }
}
