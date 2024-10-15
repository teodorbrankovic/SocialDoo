//
//  ProfileView.swift
//  SocialDoo
//
//  Created by Dominik Seemayr on 13.03.24.
//

import SwiftUI

struct ProfileView: View {
  @EnvironmentObject var user: SocialUser
  @EnvironmentObject var userManager: UserManager
  let profileUser: SocialUser
  @StateObject var feedViewModel = FeedViewModel() // for post count
  
  @State private var username = "" // for textfield
  @State private var birthdate = Date() // for datepicker
  @State private var shouldSendNewsLetter = false
  
  var body: some View {
    //    VStack {
    //      Text(profileUser.username)
    //      // Text(profileUser.id)
    //
    //      Button(user.following.contains(profileUser.id) ? "Unfollow" : "Follow") {
    //        userManager.triggerFollow(for: profileUser.id)
    //      }
    //   }
    
    VStack {
      
      Form {
        Section(header: Text("Personal Information")) {
          Text("Username: \(profileUser.username)")
          DatePicker("Birthdate", selection: $birthdate, displayedComponents: .date)
          HStack {
            Text("Post Count: ") /*\(feedViewModel.allPosts.count)")*/
            Spacer()
            Text("\(feedViewModel.allPosts.count)")
          }
          
        } // end section
        
        Section(header: Text("Actions")) {
          Toggle("Send Newsletter", isOn: $shouldSendNewsLetter)
            .toggleStyle(SwitchToggleStyle(tint: .cyan))
          
          Button("Logout") {
            userManager.logout()
          }
          .foregroundStyle(.red)
          
        }
                  
      }// end form
      
    } // end vstack
    
  }
}
