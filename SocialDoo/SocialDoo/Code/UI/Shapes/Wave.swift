//
//  Wave.swift
//  SocialDoo
//
//  Created by Teodor Brankovic on 22.04.24.
//

import SwiftUI

struct Wave: Shape {
  
  var yOffset: CGFloat = 0.5
  
  var animatableData: CGFloat {
    get {
      return yOffset
    }
    set {
      yOffset = newValue
    }
  }
  
  func path(in rect: CGRect) -> Path { // path = flat 2D object
    var path = Path()
    path.move(to: .zero) // upper left corner
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY)) // top left to top right, horiz.
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    path.addCurve(to: CGPoint(x: rect.minX, y: rect.maxY),
                  control1: CGPoint(x: rect.maxX * 0.75, y: rect.maxY - (rect.maxY * yOffset)),
                  control2: CGPoint(x: rect.maxX * 0.25, y: rect.maxY + (rect.maxY * yOffset)))
    path.closeSubpath() // connect last line with startpoint
    return path
  }
  
}

struct Wave_Preview: PreviewProvider {
  static var previews: some View {
    Wave()
      .stroke(Color.red, lineWidth: 5)
      .frame(height: 200)
      .padding()
  }
}
