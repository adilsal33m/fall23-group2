//
//  ContentView.swift
//  split
//
//  Created by Zawiyar on 04/10/2023.
//

import SwiftUI

struct ListOfExpensesCard: View {
    var body: some View {
        ZStack(alignment: .center){
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 1, x: 6,y: 6)
                .overlay(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).stroke(.black, lineWidth: 4))
                .frame(height: UIScreen.main.bounds.height/4.9)
            HStack(alignment: .center){
                Spacer()
                    Text("View List of Expenses")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(.system(size: 25))
                    Spacer()
                    Image("ExpensesList").resizable().scaledToFit().frame(height:100)
                    Spacer()
                }
            Spacer()
            .padding()
            
        }.onTapGesture {
            //ProfileView()
        }
        
    }
}
struct AddExpenseCard: View {
    var body: some View {
        ZStack(alignment: .center){
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 1, x: 6,y: 6)
                .overlay(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).stroke(.black, lineWidth: 4))
                .frame(height: UIScreen.main.bounds.height/4.9)
            HStack(alignment: .center){
                Spacer()
                    Text("Add Expense")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(.system(size: 25))
                    Spacer()
                    Image("AddNewExpense").resizable().scaledToFit().frame(height:100)
                    Spacer()
                }
            Spacer()
            .padding()
            
        }.onTapGesture {
            //ProfileView()
        }
        
    }
}
struct AddFriendsCard: View {
    var body: some View {
        NavigationStack{
            ZStack(alignment: .center){
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 1, x: 6,y: 6)
                    .overlay(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).stroke(.black, lineWidth: 4))
                    .frame(height: UIScreen.main.bounds.height/4.9)
                HStack(alignment: .center){
                    Spacer()
                    Text("Add Friends")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(.system(size: 25))
                    Spacer()
                    Image("AddFriends").resizable().scaledToFit().frame(height:100)
                    Spacer()
                }
                Spacer()
                    .padding()
                NavigationLink("", destination: ProfileView())
            }.onTapGesture {
              // enter code here
            }
        }
            
        
    }
}

struct MainView: View {
    
    @StateObject var viewModel = RegisterViewVM()
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            
            Spacer().frame(height:10)
            
            HStack{
                Text("Hello, Username!")
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
                ListOfExpensesCard()
                AddExpenseCard()
                AddFriendsCard()
            }
            
 
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
    }
}

#Preview {
    MainView()
}
