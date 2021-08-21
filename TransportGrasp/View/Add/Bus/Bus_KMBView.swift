//
//  Bus_KMBView.swift
//  Bus_KMBView
//
//  Created by Johnny on 20/8/2021.
//

import SwiftUI
import Introspect

struct Bus_KMBView: View {
    @ObservedObject var favouriteRoutes: FavouriteRoutes
    @ObservedObject var bus_KMB = Bus_KMB()
    @ObservedObject var sharedOptions: SharedOptions
    
    
    @State var filterString:String = ""
    
    var body: some View {
            ZStack{
                VStack(spacing:0){
                    
                    TextField("Route Search",text:$filterString)
                        .keyboardType(.decimalPad)
                        .padding()
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                        .introspectTextField { (textField) in
                            let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 35))
                            let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                            let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                            doneButton.tintColor = .systemBlue
                            toolBar.items = [flexButton, doneButton]
                            toolBar.setItems([flexButton, doneButton], animated: true)
                            textField.inputAccessoryView = toolBar
                        }
                    
                    List{
                        ForEach(bus_KMB.routes,id:\.self){ route in
                            if (filterString == "" || route.route.contains(filterString)){
                                NavigationLink(destination:Bus_KMBDetail(route: route,
                                                                         bus_KMB: self.bus_KMB,
                                                                         favouriteRoutes: self.favouriteRoutes)){
                                    HStack{
                                        Text(route.route)
                                        Spacer()
                                        Text(route.orig_tc)
                                        Text(" -> ")
                                        Text(route.dest_tc)
                                    }
                                    
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                }
//                if sharedOptions.loading{
//                    LoadingView()
//                }
            }
            .onAppear {
//                DispatchQueue.main.async() {
//                    sharedOptions.startLoading()
//                }
            }
            .onChange(of: bus_KMB.routes) { newValue in
//                if !newValue.isEmpty{
//                    sharedOptions.finishedLoading()
//                }
            }
    }
}

