//
//  SummaryView.swift
//  SummaryView
//
//  Created by Johnny on 20/8/2021.
//

import SwiftUI

struct SummaryView: View {
    @ObservedObject var favouriteRoutes: FavouriteRoutes
    @State var routesHandler = RoutesHandler()
    
    func delete(at offsets: IndexSet){
        if let index = offsets.first,
           favouriteRoutes.favouriteArray[index].favouriteID == favouriteRoutes.favouriteArray[index].favouriteID{
            favouriteRoutes.removeFavourite(id: favouriteRoutes.favouriteArray[index].favouriteID)
            
        }
    }
    
    func updateETA(){
        favouriteRoutes.updateETA()
    }
    
    var body: some View {
        NavigationView{
            
            ZStack{
                VStack{
                    List{
                        ForEach(favouriteRoutes.favouriteArray,id:\.self){ route in
                            VStack(alignment:.leading){
                                HStack{
                                    Text("Route \(route.favouriteID)")
                                        .padding(5)
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .strokeBorder(Color.gray,lineWidth:1)
                                        )
                                    
                                    Text(routesHandler.getCategory(targetRoute: route))
                                        .padding(2)
                                        .foregroundColor(.white)
                                        .background(Color.red)
                                        .cornerRadius(5)
                                }
                                HStack{
                                    Text(routesHandler.getTitle(targetRoute: route))
                                        .fontWeight(.heavy)
                                    Spacer()
                                }
                                HStack{
                                    //                                        Divider()
                                    HStack{
                                        Text(routesHandler.getStationName(targetRoute: route))
                                        Spacer()
                                        VStack(alignment:.leading){
                                            ForEach(route.eta,id:\.self){ eta in
                                                Text(eta)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .onDelete(perform: delete)
                    }
                    .listStyle(.plain)
                }
            }
            .onAppear(perform: {
                updateETA()
            })
            .navigationTitle("Summary")
            .navigationBarTitleDisplayMode(.inline)
        }
        
        
    }
}
