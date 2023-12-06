//
//  ProfileView.swift
//  split
//
//  Created by Zawiyar on 04/10/2023.
//

import SwiftUI

struct CustomProfileFriendCard:View {
    @State var buttonText: String
    @State var money:String
    @State var status:String
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
                    Text("Friends Name")
                        .bold()
                    Text("Expense Name")
                        .padding(.bottom,4)
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.height/28)
                            .foregroundColor(.white)
                            .shadow(color:.black, radius: 1,x:3, y:3)
                            .overlay(RoundedRectangle(cornerRadius: 10.0).stroke(.black, lineWidth: 2))
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
                    .font(.title)
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
                        CustomProfileFriendCard(buttonText: "Remind", money: "2000", status: "Owes you")
                        CustomProfileFriendCard(buttonText: "Remind", money: "4000", status: "Owes you")
                        CustomProfileFriendCard(buttonText: "Remind", money: "1000", status: "Owes you")
                        
                    }
                    .padding(.horizontal, 10)
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
                        CustomProfileFriendCard(buttonText: "Settle", money: "1000", status: "you are owed")
                            .padding(Edge.Set .top, 10)
                        CustomProfileFriendCard(buttonText: "Settle", money: "1000", status: "you are owed")
                            .padding(Edge.Set .top, 10)
                        
                    }
                    .padding(.horizontal,10)
                }
                
                
            }
            .padding()
        }
    }
}

#Preview {
    ProfileView()
}
