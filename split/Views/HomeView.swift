//
//  HomeView.swift
//  split
//
//  Created by Dua Qadeer on 03/11/2023.
//


import SwiftUI
import Firebase
import FirebaseAuth

import SwiftUI
import Firebase
import FirebaseAuth

struct NavigationCard: View {
    var text: String
    var imageIcon: String
    
    var view: AnyView
    var body: some View {
        NavigationView{
            ZStack(alignment: .center){
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 1, x: 3.5,y: 3.5)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(.black, lineWidth: 2))
                    .frame(width:UIScreen.main.bounds.width/1.2,height: UIScreen.main.bounds.height/4.9)
                HStack(alignment: .center){
                    Spacer()
                    Text(text)
                        .fontWeight(.bold)
                        .font(.system(size: 25))
                    Spacer()
                    Image(imageIcon).resizable().scaledToFit().frame(height:100)
                    Spacer()
                }
                Spacer()
                    .padding()
                
            }.onTapGesture {
            }
        }
    }
}



struct HomeView: View {
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading, spacing: 5){
                
                Spacer().frame(height:10)
                
                HStack{
                    Text("Hello, Username")
                        .fontWeight(.bold)
                        .font(.system(size: 25))
                    Spacer()
                    Circle()
                        .shadow(color:.black, radius: 1,x:4,y:4)
                        .frame(width:50)
                        .foregroundColor(.white)
                        .overlay(
                            Image(systemName: "person.fill")
                        )
                        .overlay(Circle().stroke(Color.black, lineWidth: 2))
                }
                
                Spacer().frame(height: 10)
                VStack{
                    NavigationLink(destination: ProfileView(), label: {
                        NavigationCard(text: "View List of Expenses",imageIcon: "ExpensesList",view: AnyView(ProfileView()))

                    })
                    .foregroundColor(.black)
                    NavigationLink(destination: AddExpenseView(), label: {
                        NavigationCard(text: "AddExpense",imageIcon: "AddNewExpense", view: AnyView(AddExpenseView()))
                    })
                    .foregroundColor(.black)
                    NavigationLink(destination: AddParticipants(), label: {
                        NavigationCard(text: "Add Friends",imageIcon: "AddFriends", view: AnyView(AddParticipants()))
                    })
                    .foregroundColor(.black)
                    
                    
                }
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
        }
    }
}

#Preview {
    HomeView()
}
