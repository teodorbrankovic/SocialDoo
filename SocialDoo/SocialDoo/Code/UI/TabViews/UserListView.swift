//
//  UserListView.swift
//  SocialDoo
//
//  Created by Dominik Seemayr on 13.03.24.
//

import SwiftUI

struct UserListView: View {
  @EnvironmentObject var userManager: UserManager
  @State var allUsers: [SocialUser] = []
  
  var body: some View {
    
    NavigationView {
      VStack {
        
        List(allUsers, id: \.id) { user in
          
          HStack(spacing: 15) {
            
            Image(systemName: "person")
              .resizable()
              .scaledToFit()
              .frame(height: 25)
              .cornerRadius(4)
                      
            Text(user.username)
              .font(.title2)
          }
          
          //        NavigationLink(value: Router.Destination.profileView(user), label: {
          //          Text(user.username)
          //        })
        } // end List
        .listStyle(PlainListStyle())
      }
      .navigationTitle("SocialDoo Users")
      .task {
        allUsers = await userManager.getAllUsers()
      }
    }
   
  }
}

