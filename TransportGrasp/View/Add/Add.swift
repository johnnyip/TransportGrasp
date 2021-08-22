//
//  Add.swift
//  Add
//
//  Created by Johnny on 21/8/2021.
//

import SwiftUI

struct Add: View {
    @ObservedObject var favouriteRoutes: FavouriteRoutes
    @ObservedObject var sharedOptions: SharedOptions

    
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    Spacer()
                    
                    //BUS
                    Group{
                        HStack{
                            Image(systemName: "bus.doubledecker")
                                .font(.title)
                            Text("Bus")
                                .font(.title)
                        }
                        HStack{
                            NavigationLink(destination: Bus_KMBView(favouriteRoutes: self.favouriteRoutes,sharedOptions: self.sharedOptions)) {
                                Text("KMB")
                                    .font(.title2)
                                    .padding(.horizontal,15)
                                    .padding(20)
                                    .background(Color.init("kmbRed"))
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                
                            }
                        }
                        Divider()
                    }
                    
                    //MTR
                    Group{
                        HStack{
                            Image(systemName: "tram.tunnel.fill")
                                .font(.title)
                            Text("MTR")
                                .font(.title)
                        }
                        HStack{
                            NavigationLink(destination: MTR_TungChungView(favouriteRoutes: self.favouriteRoutes)) {
                                Text("東涌綫")
                                    .font(.title2)
                                    .padding(.horizontal,15)
                                    .padding(20)
                                    .background(Color.init("mtrTungChung"))
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                            }
                            NavigationLink(destination: MTR_TuenMaView(favouriteRoutes: self.favouriteRoutes)) {
                                Text("屯馬綫")
                                    .font(.title2)
                                    .padding(.horizontal,15)
                                    .padding(20)
                                    .background(Color.init("mtrTuenMa"))
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                            }
                        }
                        HStack{
                            NavigationLink(destination: MTR_TKOView(favouriteRoutes: self.favouriteRoutes)) {
                                Text("將軍澳綫")
                                    .font(.title2)
                                    .padding(.horizontal,15)
                                    .padding(20)
                                    .background(Color.init("mtrTKO"))
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                            }
                            NavigationLink(destination: MTR_AirportView(favouriteRoutes: self.favouriteRoutes)) {
                                Text("機場快綫")
                                    .font(.title2)
                                    .padding(.horizontal,15)
                                    .padding(20)
                                    .background(Color.init("mtrAirport"))
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                            }
                        }

                        Divider()
                    }


//                    //LightRail
//                    Group{
//                        HStack{
//                            Image(systemName: "tram")
//                                .font(.title)
//                            Text("Light Rail")
//                                .font(.title)
//                        }
//                        HStack{
//                            NavigationLink(destination: Bus_KMBView(favouriteRoutes: self.favouriteRoutes)) {
//                                Text("Light Rail")
//                                    .font(.title2)
//                                    .padding(.horizontal,15)
//                                    .padding(20)
//                                    .background(Color.init("kmbRed"))
//                                    .foregroundColor(.black)
//                                    .cornerRadius(20)
//
//                            }
//                        }
//                        Divider()
//                    }
//
//
//                    //MINIBUS
//                    Group{
//                        HStack{
//                            Image(systemName: "bus")
//                                .font(.title)
//                            Text("Minibus")
//                                .font(.title)
//                        }
//                        HStack{
//                            NavigationLink(destination: Bus_KMBView(favouriteRoutes: self.favouriteRoutes)) {
//                                Text("Minibus")
//                                    .font(.title2)
//                                    .padding(.horizontal,15)
//                                    .padding(20)
//                                    .background(Color.init("kmbRed"))
//                                    .foregroundColor(.black)
//                                    .cornerRadius(20)
//
//                            }
//                        }
//                        Divider()
//                    }

                    
                    Spacer()
                }
            }
            .navigationTitle("Add")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

