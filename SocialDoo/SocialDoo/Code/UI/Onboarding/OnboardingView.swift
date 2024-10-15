//
//  OnboardingView.swift
//  SocialDoo
//
//  Created by Dominik Seemayr on 13.03.24.
//

import SwiftUI

struct OnboardingView: View {
  @EnvironmentObject var userManager: UserManager
  
  @State var currentPageIndex: Int = 0
  @State var waveAnimation = false // for animating the curved rectangle
  
  var body: some View {
    
    ZStack {
      VStack() {
        
        Wave(yOffset: waveAnimation ? -0.5 : 0.5) // if button pressed -> animate
          .fill(.cyan)
          .frame(height:150.0)
          .shadow(radius: 4)
          .animation(Animation.easeInOut(duration: 1))
        
        TabView(selection: $currentPageIndex) { // index?
          welcomePage.tag(0)
          setNamePage.tag(1)
          loginPage.tag(2)
        }
        .tabViewStyle(.page(indexDisplayMode: .always)) // dots
        .indexViewStyle(.page(backgroundDisplayMode: .always)) // dots color
        .indexViewStyle(.page)
        .onChange(of: currentPageIndex) { _ in // perform wave animation when swipped
          self.waveAnimation.toggle()
        }
        
      }
      .ignoresSafeArea() // for Wave
    } // end ZStack
  }
  
  var welcomePage: some View {
    VStack(spacing: 5) {
      
      Spacer()
      
      Image("Onboarding2")
        .resizable()
        .scaledToFit()
      
      Text("SocialDoo")
        .font(.title).bold()
      
      Text("Create and share your to-dos with friends - get started now!")
        .multilineTextAlignment(.center)
        .foregroundStyle(.secondary)
      
      Spacer()
    }
    .padding(.horizontal, 40) // für den Rand
  }
  
  var setNamePage: some View {
    ZStack {
      
      VStack {
        
        TypingAnimationView(font: .largeTitle, color: .black, text: "How do your friends call you?")
          .bold()
        
        TextField("Your Name", text: $userManager.username)
          .padding()
          .frame(width: 300, height: 50)
          .background(Color.black.opacity(0.05))
          .cornerRadius(10)
        
        Button("Login") {
          nextPage()
          self.waveAnimation.toggle()
        }
        .foregroundStyle(.white)
        .frame(width: 300, height: 50)
        .background(Color.cyan)
        .cornerRadius(10)
        .disabled(userManager.username.isEmpty)
      }
      
    }
    
  }
  
  var loginPage: some View {
    
    ZStack {
      
      VStack {
        
        Text("Ready to share your TODO's with your friends?")
          .bold()
        
        TypingAnimationView(font: .subheadline, color: .black, text: "Let's get started!")
        
        Image("Onboarding1")
          .resizable()
          .scaledToFit()
          .animation(.easeInOut)
        
        Button("Finish") {
          userManager.loginAnonym()
        }
        .foregroundStyle(.white)
        .frame(width: 200, height: 50)
        .background(.cyan)
        .cornerRadius(10)

      }
      
    }
    
  }
  
  func nextPage() {
    currentPageIndex += 1
  }
}

