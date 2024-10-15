//
//  TodoListView.swift
//  SocialDoo
//
//  Created by Dominik Seemayr on 19.03.24.
//

import SwiftUI
import SwiftData

struct TodoListView: View {
  @Environment(\.modelContext) var modelContext
  @Query var allTodos: [Todo]
  
  @State var showNewTodoSheet = false
  @State var newTodoCaption = ""
  @State var isTapped = false
  
  var body: some View {
    
  
     
      //      ScrollView {
      //
      //        VStack {
      //
      //          ForEach(allTodos) { todo in
      //            NavigationLink(value: Router.Destination.finishTodo(todo), label: {
      //              Text("TODO: \(todo.caption)")
      //            })
      //          }
      //
      //          //          Button("Add new Todo") {
      //          //            showNewTodoSheet = true
      //          //          }
      //
      //          HStack  {
      //            Spacer(minLength: 20)
      //            Button(action: {
      //              showNewTodoSheet = true
      //            }, label: {
      //              Image(systemName: "plus")
      //            })
      //          }
      //
      //
      //        }
      //
      //      } // end ScrollView
      //      .sheet(isPresented: $showNewTodoSheet, content: {
      //        newTodoView
      //          .presentationDetents([.medium])
      //      })
      
      NavigationView {
        VStack {
          List(allTodos) { todo in
            NavigationLink(value: Router.Destination.finishTodo(todo), label: {
              VStack (alignment: .leading) {
                Text(todo.caption)
                  .font(.title2)
                  .swipeActions {
                    Button {
                      
                    } label: {
                      Text("Delete")
                        .foregroundStyle(.red)
                    }
                  }
                
                Text(todo.createdAt.formatted())
                  .font(.footnote)
              }
            })
          }
          .listStyle(PlainListStyle())
        }
        .navigationTitle("To Do List")
        .toolbar {
          Button {
            showNewTodoSheet = true
          } label: {
            Image(systemName: "plus")
          }
        }
        
      } // end nview
      .sheet(isPresented: $showNewTodoSheet, content: {
        newTodoView
          .presentationDetents([.medium])
      })
      
    
  } // end view
  
  
  var newTodoView: some View {
    VStack {
      
      TypingAnimationView(font: .largeTitle, color: .cyan, text: "What do you want to do?")
        .bold()
      //      Text("What do you want to do?")
      //        .font(.headline)
      
      HStack {
        TextField("Your Todo", text: $newTodoCaption)
          .padding(.vertical, 12)
          .background(.gray.opacity(0.1))
          .cornerRadius(5)
      }
      .padding(.horizontal, 7)
      
      
      /// add some design here
      
      Button("Save") {
        let newTodo = Todo(caption: newTodoCaption)
        modelContext.insert(newTodo)
        showNewTodoSheet = false
      }
      .disabled(newTodoCaption.isEmpty)
    }
    
  }
}

