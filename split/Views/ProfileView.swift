//
//  ProfileView.swift
//  split
//
//  Created by Zawiyar on 04/10/2023.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct CustomProfileFriendCard:View {
    @State var buttonText: String
    @State var money:String
    @State var status:String
    @State var name: String
    @State var expenseName: String
    @State var email:String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15.0)
                .frame(height: UIScreen.main.bounds.height/8)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 1, x: 3.5, y:3.5)
                .overlay(RoundedRectangle(cornerRadius: 15.0).stroke(.black, lineWidth: 2))
            
            HStack(){
                
                CustomPerson(Name: "")
                    .padding()
                VStack{
                    Text(name)
                        .bold()
                    Text(expenseName)
                        .padding(.bottom,4)
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.height/28)
                            .foregroundColor(.white)
                            .shadow(color:.black, radius: 1,x:3, y:3)
                            .overlay(RoundedRectangle(cornerRadius: 10.0).stroke(.black, lineWidth: 2))
                            .onTapGesture {
                                
                                if let
                                
                                viewModel.deleteUser(currentEmail: <#T##String#>, userEmail: <#T##String#>, completion: <#T##(Bool) -> Void#>)
                            }
                        Text("\(buttonText)")

                    }   
                }
                
                
                Spacer()
                VStack{
                    Text("\(status)")
                        .foregroundColor(.gray)
                    Text("\(money)")
                        .foregroundColor(.black)


                }
                    
            .padding(.horizontal,20)

        }
        .onTapGesture {
            
            }
            
        }
    }
}

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewVM()
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    NavigationLink(destination: HomeView(),label: {
                        CircularShadowButton(icon: "house.fill")
                    })
                    .foregroundColor(.black)
                    
                    Spacer()
                    CircularShadowButton(icon: "person.fill")
                }
                Text("List of Expenses")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .bold()
                
                HStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: UIScreen.main.bounds.width/2.6, height: UIScreen.main.bounds.height/10)
                            .foregroundColor(.white)
                            .shadow(color:.black, radius: 1,x:3.5,y:3.5)
                            .overlay(RoundedRectangle(cornerRadius: 15.0).stroke(.green, lineWidth: 3))
                        
                        Text("you are owed\n        4000")
                        
                    }
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: UIScreen.main.bounds.width/2.6, height: UIScreen.main.bounds.height/10)
                            .foregroundColor(.white)
                            .shadow(color:.black, radius: 1,x:4,y:4)
                            .overlay(RoundedRectangle(cornerRadius: 15.0).stroke(.red, lineWidth: 2))
                        
                        Text("you owe\n   2000")
                        
                    }
                    
                    
                }
                
                HStack{
                    Text("Owes you")
                        .font(.title3)
                        .bold()
                    Spacer()
                    
                }
                .padding(Edge.Set .top, 10)
                ScrollView{
                    VStack{
                        
                        
                        
                        
                        ForEach(viewModel.expenseFriends , id: \.id){ expense in
                            CustomProfileFriendCard(buttonText: "Remind", money: "\(expense.amount)", status: "Owes you", name: expense.name, expenseName: viewModel.expense?.name ?? " ", email: expense.email)
                        }

                        
                        
                        
//                        CustomProfileFriendCard(buttonText: "Remind", money: "2000", status: "Owes you")
//                        CustomProfileFriendCard(buttonText: "Remind", money: "4000", status: "Owes you")
//                        CustomProfileFriendCard(buttonText: "Remind", money: "1000", status: "Owes you")
                        
                    }
                    .padding(.horizontal, 10)
                }
                .onAppear{
                    viewModel.fetchEmails(email: Auth.auth().currentUser?.email ?? "") { success in
                        if success {
                            // The Firestore query has completed successfully
                            viewModel.fetchOwesUsers {
                                // Code to execute after fetching users who owe
                                
                                print(viewModel.usersYouOweEmails)
                                print(viewModel.usersOweEmails)
                                print(viewModel.usersYouOwe)
                            }
                            
                        } else {
                            // Handle the case where the query was not successful
                            print("Failed to fetch user data")
                        }
                    }
                    viewModel.fetchExpense(email: Auth.auth().currentUser?.email ?? ""){expense in
                        print("there we")
                        print(viewModel.expense)
                        print(viewModel.expenseFriends)
                        print(expense)
                    }
                }
                HStack{
                    Text("You are owed")
                        .font(.title3)
                        .bold()
                    Spacer()
                    
                }
                .padding(Edge.Set .top, 10)
                
                ScrollView{
                    VStack{
                        
                        ForEach(viewModel.expensesYouOwe , id: \.createdBy){ expense in
                            CustomProfileFriendCard(buttonText: "Settle", money: "\(expense.friends[0].amount)", status: "you Owe", name: expense.createdBy, expenseName: viewModel.expense?.name ?? " ", email: expense.createdBy)
                        }

//                        CustomProfileFriendCard(buttonText: "Settle", money: "1000", status: "you are owed", name: "", expenseName: "")
//                            .padding(Edge.Set .top, 10)
                        
                    }
                    .padding(.horizontal,10)
                }
                .onAppear{
                    viewModel.fetchEmails(email: Auth.auth().currentUser?.email ?? "") { success in
                        if success {
                            // The Firestore query has completed successfully
                            viewModel.fetchUserYouOwe {
                                // Code to execute after fetching users who owe
                                
                                print("Expense Data: \(viewModel.expensesYouOwe)")
//                                print(viewModel.usersOweEmails)
//                                print(viewModel.usersYouOwe)
                            }
                            
                        } else {
                            // Handle the case where the query was not successful
                            print("Failed to expense user data")
                        }
                    }
                }
                
                
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ProfileView()
}
