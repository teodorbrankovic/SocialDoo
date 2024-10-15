//
//  TypingAnimationView.swift
//  SocialDoo
//
//  Created by Teodor Brankovic on 11.04.24.
//

import SwiftUI

struct TypingAnimationView: View {
  
  var font: Font
  var color: Color
  var text: String
  @State private var displayCharacters = ""
  var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
  
  var body: some View {
    Text(displayCharacters)
      .font(.subheadline)
      .foregroundStyle(color)
      .onReceive(timer) { _ in
        
        if displayCharacters.count < text.count {
          let index = text.index(text.startIndex, offsetBy:
                                  displayCharacters.count)
          displayCharacters.append(text[index])
        }
        
      }
  }
}

