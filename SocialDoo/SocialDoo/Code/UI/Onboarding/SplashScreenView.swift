//
//  SplashScreenView.swift
//  SocialDoo
//
//  Created by Teodor Brankovic on 11.04.24.
//

import SwiftUI

struct SplashScreenView: View {
  @State private var isActive = false
  @State private var size = 0.8
  @State private var opacity = 0.5
  
  @StateObject var userManager = UserManager.shared
  
  var body: some View {
    
    if isActive {
      if let user = userManager.user {
        StackRouter {
          RootView()
        }
        .environmentObject(user) // visible over whole app
      } else {
        OnboardingView()
      }
      
    } else {
      ZStack {
        VStack {
          
          VStack {
            Lottie(lottieFile: "Lottie5")
            
            HStack(spacing: -1) { // a little hstack for fancy title
              Text("Social")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
              Text("Doo")
                .font(.title)
                .foregroundStyle(.cyan)
            }
            
          } // end VStack
          .scaleEffect(size)
          .opacity(opacity)
          .onAppear {
            withAnimation(.easeIn(duration: 1.2)) {
              self.size = 0.9
              self.opacity = 1.0
            }
          }
          
        } // end VStack
      } // end ZStack
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.9) {
          self.isActive = true
        }
      }
    } // end else
    
  }
}

