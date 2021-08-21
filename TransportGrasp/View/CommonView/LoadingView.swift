//
//  LoadingView.swift
//  amplifyDemo
//
//  Created by Johnny on 29/6/2021.
//

import SwiftUI
import ActivityIndicatorView

struct LoadingView: View {
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .opacity(0.5)
                .frame(maxWidth:.infinity, maxHeight: .infinity,alignment: .center)
            
            ActivityIndicatorView(isVisible: .constant(true), type: .arcs)
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)

        }
        
        
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
