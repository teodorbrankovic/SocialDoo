//
//  Lottie.swift
//  SocialDoo
//
//  Created by Teodor Brankovic on 11.04.24.
//

import SwiftUI
import Lottie

struct Lottie: View {
  
  var lottieFile: String
  
    var body: some View {
      
      LottieView(animation: .named(lottieFile))
        .configure({ LottieAnimationView in
          LottieAnimationView.contentMode = .scaleAspectFit
        })
        .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
        .animationDidFinish { completed in
          // empty
        }
    }
}

#Preview {
  Lottie(lottieFile: "Lottie1.json")
}
