//
//  keyboardFunctions.swift
//  keyboardFunctions
//
//  Created by Johnny on 20/8/2021.
//

import SwiftUI


extension  UITextField {
   @objc func doneButtonTapped(button:UIBarButtonItem) -> Void {
      self.resignFirstResponder()
   }
}
