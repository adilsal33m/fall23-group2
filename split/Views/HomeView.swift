//
//  HomeView.swift
//  split
//
//  Created by Dua Qadeer on 03/11/2023.
//


import SwiftUI
import Firebase
import FirebaseAuth

struct NavigationCard: View {
    var text: String
    var imageIcon: String
    var body: some View {
        ZStack(alignment: .center){
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 1, x: 6,y: 6)
                .overlay(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).stroke(.black, lineWidth: 4))
                .frame(height: UIScreen.main.bounds.height/4.9)
            HStack(alignment: .center){
                Spacer()
                    Text(text)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(.system(size: 25))
                    Spacer()
                    Image(imageIcon).resizable().scaledToFit().frame(height:100)
                    Spacer()
                }
            Spacer()
            .padding()
            
        }.onTapGesture {
            //ProfileView()
        }
        
    }
}



struct HomeView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            
            Spacer().frame(height:10)
            
            HStack{
                Text("Hello, Username")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
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
                NavigationCard(text: "View List of Expenses",imageIcon: "ExpensesList")
                NavigationCard(text: "AddExpense",imageIcon: "AddNewExpense")
                NavigationCard(text: "Add Friends",imageIcon: "AddFriends")
             
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
    }
}

#Preview {
    HomeView()
}
