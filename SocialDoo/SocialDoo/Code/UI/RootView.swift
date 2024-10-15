//
//  RootView.swift
//  SocialDoo
//
//  Created by Dominik Seemayr on 13.03.24.
//

import SwiftUI

struct RootView: View {
  @EnvironmentObject var user: SocialUser
  @EnvironmentObject var userManager: UserManager
  @Environment(AdManager.self) var adManager
  @State private var isActive: Bool = true
  
  @State var currentTab: Tab = .Home // for ToolBar
  init () {
    UITabBar.appearance().isHidden = true
  }
  
  @Namespace var animation
  
  var body: some View {
    
    VStack {
      (
        Text("Social")
          .font(.title2)
        +
        Text("Doo")
          .font(.title2)
          .foregroundStyle(.cyan)
      )
      
      TabView(selection: $currentTab) {
        
        FeedView()
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .tag(Tab.Home)
        
        //        FeedView()
        //          .frame(maxWidth: .infinity, maxHeight: .infinity)
        //          .tag(Tab.Feed)
        
        TodoListView()
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .tag(Tab.Todo)
        
        UserListView()
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .tag(Tab.Users)
        
        ProfileView(profileUser: user)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .tag(Tab.Profile)
        
      }
      .overlay(
        HStack(spacing: 0) {
          ForEach(Tab.allCases, id: \.rawValue) { tab in
            TabButton(tab: tab)
          }
          .padding(.vertical)
          .padding(.bottom, getSafeArea().bottom == 0 ? 5 : (getSafeArea().bottom - 15))
          .background(.cyan)
        }
        ,
        alignment: .bottom
      ).ignoresSafeArea(.all, edges: .bottom)
      
      
      //    StackRouter() {
      //      ZStack {
      //
      //        VStack {
      //          Spacer()
      //          Text("Hi, \(user.username) 🎉")
      //            .font(.headline)
      //
      //          NavigationLink(value: Router.Destination.userList, label: {
      //            Text("All Users")
      //          })
      //
      //          Text("SETUP: \(adManager.setupDone) - Interstitla Loaded: \(adManager.interstitial != nil)")
      //          Button("SHOW INTERSTITIAL") {
      //            adManager.showInterstitial()
      //          }
      //
      //          NavigationLink(value: Router.Destination.feedView, label: {
      //            Text("FEED")
      //          })
      //
      //          NavigationLink(value: Router.Destination.todoList, label: {
      //            Text("Todo List")
      //          })
      //
      //          Button("Logout") {
      //            userManager.logout()
      //          }
      //
      //        } // end VStack
      //
      //      } // end ZStack
      //    } // end StackRouter
    }
    
  } // end body
  
  // MARK: function for TabView
  func TabButton(tab: Tab) -> some View {
    GeometryReader { proxy in
      Button(action: {
        withAnimation(.spring()) {
          currentTab = tab
        }
      }, label: {
        VStack(spacing: 0) {
          Image(systemName: currentTab == tab ? tab.rawValue + ".fill" : tab.rawValue)
            .resizable()
            .foregroundStyle(.white)
            .aspectRatio(contentMode: .fit)
            .frame(width: 25, height: 25)
            .frame(maxWidth: .infinity)
            .background(
              ZStack {
                if currentTab == tab {
                  MaterialEffect(style: .light)
                    .clipShape(Circle())
                    .matchedGeometryEffect(id: "Tab", in: animation)
                  
                  Text(tab.Tabname)
                    .foregroundStyle(.white)
                    .font(.footnote)
                    .padding(.top, 50)
                }
              }
            ).contentShape(Rectangle())
            .offset(y: currentTab == tab ? -15 : 0)
        }
      }) // end Button
    } // end GeometryReader
    .frame(height: 25)
  } // end TabButton func
  
} // end RootView



// MARK: Enum for TabView
enum Tab: String, CaseIterable {
  case Home = "house"
  //case Feed = "list.bullet"
  case Todo = "list.bullet.clipboard"
  case Users = "person.2"
  case Profile = "person"
  
  
  var Tabname: String {
    switch self {
    case .Home:
      return "Home"
      //    case .Feed:
      //      return "Feed"
    case .Todo:
      return "Todo"
    case .Users:
      return "Users"
    case .Profile:
      return "Profile"
    }
  }
}

extension View {
  
  func getSafeArea() -> UIEdgeInsets {
    
    guard let screen = UIApplication.shared.connectedScenes.first as?
            UIWindowScene else {
      return .zero
    }
    
    guard let safeArea = screen.windows.first?.safeAreaInsets else {
      return .zero
    }
    
    return safeArea
  }
}

struct MaterialEffect: UIViewRepresentable {
  var style : UIBlurEffect.Style
  
  func makeUIView(context: Context) -> UIVisualEffectView {
    let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
    
    return view
  }
  
  func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
    //
  }
}



