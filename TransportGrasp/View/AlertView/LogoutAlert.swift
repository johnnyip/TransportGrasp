//
//  LoginStateAlertView.swift
//  amplifyDemo
//
//  Created by Johnny on 28/6/2021.
//

import SwiftUI
import Firebase

struct LogoutAlert: View {
    @ObservedObject var eventsOfUser: EventsOfUser
    @Binding var signedIn: Bool
    @Binding var showPopup: Bool
    
    
    var body: some View {
        if showPopup {
        VStack(spacing:30){
            Text("Are you sure you want to sign out?")
                .multilineTextAlignment(.center)
                .padding([.top, .leading, .trailing])
            HStack{
                Button(action: {
                    self.showPopup = false
                }) {
                    Text("Cancel")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    
                }
                .frame(width: 100, height: 40)
                .background(Color.blue)
                .cornerRadius(10)
                
                
                Button(action: {
                    eventsOfUser.events = []
                    self.showPopup = false
                    self.signedIn = false
                    do {
                      try Auth.auth().signOut()
                    } catch let signOutError as NSError {
                      print ("Error signing out: %@", signOutError)
                    }
                }) {
                    Text("Confirm")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    
                }
                .frame(width: 100, height: 40)
                .background(Color.red)
                .cornerRadius(10)
                
            }
        }
        
        .frame(width: 300, height: 200)
        .background(Color.init("alert"))
        .cornerRadius(30)
        }
    }
}




//struct LogoutAlert_Previews: PreviewProvider {
//    static var previews: some View {
//        LogoutAlert(signedIn: .constant(true),showPopup: .constant(true))
//    }
//}
