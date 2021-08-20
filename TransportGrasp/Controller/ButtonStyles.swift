//
//  ButtonStyles.swift
//  amplifyDemo
//
//  Created by Johnny on 28/6/2021.
//

import SwiftUI

struct FullWidthButton: ButtonStyle{
    func makeBody(configuration: FullWidthButton.Configuration) -> some View{
        let pressed = configuration.isPressed
        return configuration.label
            .padding()
            .font(.system(size: 25))
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(pressed ? 1.05 : 1.0)
            .padding(.horizontal,10.0)

    }
}

struct FullWidthButtonSmaller: ButtonStyle{
    func makeBody(configuration: FullWidthButton.Configuration) -> some View{
        let pressed = configuration.isPressed
        return configuration.label
            .padding()
            .font(.system(size: 20))
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(pressed ? 1.05 : 1.0)
            .padding(.horizontal,5)

    }
}

struct SmallButton: ButtonStyle{
    func makeBody(configuration: FullWidthButton.Configuration) -> some View{
        return configuration.label
            .padding(7)
            .background(Color.white)
            .foregroundColor(.blue)
            .padding(.horizontal,5.0)

    }
}
