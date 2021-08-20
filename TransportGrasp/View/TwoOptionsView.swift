//
//  TwoOptionsView.swift
//  amplifyDemo
//
//  Created by Johnny on 28/6/2021.
//

import SwiftUI

struct TwoOptionsView: View {
    @State var alertMessage: String
    @State var optionString:String
    @Binding var showPopup: Bool
    @Binding var OptionChosen: Bool
    
    
    var body: some View {
        if showPopup{
        VStack(spacing:30){
            Text(alertMessage.localized())
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
                    self.showPopup = false
                    self.OptionChosen = true
                }){
                    
                    Text(optionString.localized())
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
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.black,lineWidth:0.2)
        )
        }
    }
}



//struct TwoOptionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        TwoOptionsView(alertMessage: .constant("Test Alert"), showTwoOptionPopup: .constant(true), twoOptionPopupOption: .constant("Confirm"), optionObserving: .constant("nothing"))
//    }
//}
