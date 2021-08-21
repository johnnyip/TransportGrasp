//
//  PopupAlertView.swift
//  amplifyDemo
//
//  Created by Johnny on 28/6/2021.
//

import SwiftUI

struct PopupAlertView: View {
    @Binding var alertMessage: String
    @Binding var showPopup: Bool
    
    var body: some View {
        if showPopup{
        VStack(spacing:30){
            
            Text(alertMessage)
                .multilineTextAlignment(.center)
                .padding([.top, .leading, .trailing])
            
            
            Button(action: {
                self.showPopup = false
            }) {
                Text("Okay")
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    
            }
            .frame(width: 100, height: 40)
            .background(Color.blue)
            .cornerRadius(10)
        }
        .frame(width: 300, height: 200)
        .background(Color.init("alert"))
        .cornerRadius(30)
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.black,lineWidth:0.2)
        )
        }

    }
}

