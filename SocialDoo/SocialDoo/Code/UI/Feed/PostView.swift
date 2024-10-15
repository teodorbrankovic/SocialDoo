//
//  PostView.swift
//  SocialDoo
//
//  Created by Dominik Seemayr on 20.03.24.
//

import SwiftUI
import FirebaseStorage

struct PostView: View {
  let post: SocialPost
  @EnvironmentObject var user: SocialUser
  @State var loadedTodoImage: UIImage?
  @State var following = false
  @State var isLiked = false
  
  ///
  /// Design here ImagePosts
  ///
  var body: some View {
    VStack (spacing: 15) {
      
      HStack { // for user-profile-pic, name etc.
        
        Image(systemName: "person.fill")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 45, height: 45)
          .clipShape(Circle())
        
        // Text(post.caption)
        Text(user.username)
          .fontWeight(.semibold)
        //.font(.footnote)
        
        Spacer()
        
        //        Button(action: {}, label: {
        //          Image(systemName: "plus")
        //            .foregroundStyle(.primary)
        //        })
        
        if following {
          Button(action: {}, label: {
            Image(systemName: "plus")
              .foregroundStyle(.cyan)
          })
        } else {
          Button("Follow") {
            following.toggle()
          }
          .foregroundStyle(.cyan)
        }
        
        
      } // end hstack
      
      if let loadedTodoImage { // posted image
        Image(uiImage: loadedTodoImage)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 375, height: 300)
          .cornerRadius(15)
        //            .scaledToFit()
        //            .frame(width: 200, height: 200)
      }
      
      HStack (spacing: 15) { // for heartLike, etc.
        
        Button(action: {
          isLiked.toggle()
        }, label: {
          if isLiked {
            Image(systemName: "suit.heart.fill")
              .font(.system(size: 25))
              .foregroundStyle(.red)
          } else {
            Image(systemName: "suit.heart")
              .font(.system(size: 25))
          }
        })
        
        Button(action: {}, label: {
          Image(systemName: "paperplane")
            .font(.system(size: 23))
        })
        
        Spacer()
        
        Button(action: {}, label: {
          Image(systemName: "bookmark")
            .font(.system(size: 23))
        })
      }
      .foregroundStyle(.primary)
      
      
      // username and caption
      HStack {
        Text(user.username)
          .fontWeight(.bold)
        
        Text(post.caption)
        Spacer()
      }
      .padding(6)
      
      Divider()
      
    } // end vstack
    .padding()
    //.background(.gray)
    .onChange(of: post.mainImageReference, initial: true) {
      reloadImage()
    }
    
  }
  
  func reloadImage() {
    guard let imageReference = post.mainImageReference else { return }
    
    let imageRef = Storage.storage().reference().child("User/\(post.byUserId)/Posts/\(imageReference)")
    
    imageRef.getData(maxSize: .max, completion: { data, error in
      if let error {
        print(error.localizedDescription)
      }
      
      guard let data else { return }
      loadedTodoImage = UIImage(data: data)
    })
  }
  
}
