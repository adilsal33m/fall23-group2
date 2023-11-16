//
//  RegisterView.swift
//  split
//
//  Created by Zawiyar on 04/10/2023.
//

import SwiftUI

struct RegisterView: View {
    @State private var showHomeScreen = false
    @StateObject var viewModel = RegisterViewVM()
        
        
    //    init() {
    //        for family in UIFont.familyNames{
    //            print(family)
    //            for font in UIFont.fontNames(forFamilyName: family){
    //                print(font)
    //            }
    //        }
    //    }
        
        var body: some View {
            NavigationView {
                VStack{
                    Spacer()
                    Text("SPLIT")
                        .font(.custom("PressStart2P-Regular", size: 50))
                        .shadow(color: .black, radius: 4, x: 2,y:3)
                    Spacer()
        //            Spacer().frame(height: 50)
                    CustomTextField(textController: $viewModel.name, text: "Name")
                        .frame(width: UIScreen.main.bounds.width/1.15, height: UIScreen.main.bounds.height/17)
                    Spacer().frame(height:20)
                    CustomTextField(textController: $viewModel.email, text: "Email")
                        .frame(width: UIScreen.main.bounds.width/1.15, height: UIScreen.main.bounds.height/17)
                    Spacer().frame(height:20)
                    CustomTextField(textController: $viewModel.password, text: "Password")
                        .frame(width: UIScreen.main.bounds.width/1.15, height: UIScreen.main.bounds.height/17)
                    Spacer().frame(height:80)
                    
                    NavigationLink(destination: HomeView(), isActive: $showHomeScreen, label: {EmptyView()})
                    
                    CustomButton(text: "Register")
                        .frame(width:UIScreen.main.bounds.width/3.2,height: 30)
                        .onTapGesture {
                            viewModel.register{success in
                            if success {
                                print("Registration successful")
                                viewModel.addUser()
                                self.showHomeScreen = true
                                
                                }
                            }
                            
                            print("register Button Tapped")
                        }
                    
                    Spacer()
                    
                    NavigationLink(destination: LoginView(), label: {
                        
                        Text("Already have an Account")
                            .padding(.all, 30)
                            .bold()
                            .font(.system(size: 20))
                            .shadow(color: .black, radius: 0.5, x: 1,y: 2)
                    })
                    .navigationBarHidden(true)
                    .foregroundColor(.black)
                    .navigationBarBackButtonHidden(true)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
}

#Preview {
    RegisterView()
}
