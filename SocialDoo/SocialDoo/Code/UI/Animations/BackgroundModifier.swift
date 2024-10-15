//
//  BackgroundModifier.swift
//  SocialDoo
//
//  Created by Teodor Brankovic on 11.04.24.
//

import SwiftUI

// MARK: Just a struct for modifying the background
struct BackgroundModifier: View {
  
  var color1: Color
  var color2: Color
  
  var body: some View {
    LinearGradient(gradient: Gradient(colors: [color1, color2]),
                   startPoint: .topLeading,
                   endPoint: .bottomTrailing)
    .ignoresSafeArea()
  }
  
}
