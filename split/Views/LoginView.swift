//
//  LoginView.swift
//  split
//
//  Created by Zawiyar on 04/10/2023.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct CustomTextField: View {
    @Binding var textController: String
    var text: String
    var body: some View {
        ZStack(alignment: .trailing) {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color.white)
                .shadow(color: Color.black.opacity(1), radius: 0, x: 6, y: 6)
            
            TextField(text, text: $textController)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 10, trailing: 16))
                .font(Font.system(size: 22, design: .default))
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 3)
                )
        }
    }
}

struct CustomButton: View {
    var text:String
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color.white)
                .shadow(color: Color.black.opacity(1), radius: 0, x: 5, y: 5)
            
            Text(text)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 10, trailing: 16))
                .font(Font.system(size: 22, design: .default)).bold()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 0)
                )
        }
    }
}


struct LoginView: View {
    @StateObject var viewModel = LoginViewVM()
    @State private var showHomeScreen = false
    
//    init() {
//        for family in UIFont.familyNames{
//            print(family)
//            for font in UIFont.fontNames(forFamilyName: family){
//                print(font)
//            }
//        }
//    }
//    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                Text("SPLIT")
                    .font(.custom("PressStart2P-Regular", size: 50))
                    .shadow(color: .black, radius: 2, x: 2,y:3)
                Spacer()
                //            Spacer().frame(height: 50)
                CustomTextField(textController: $viewModel.email, text: "Email")
                    .frame(width: UIScreen.main.bounds.width/1.15, height: UIScreen.main.bounds.height/17)
                Spacer().frame(height:20)
                CustomTextField(textController: $viewModel.password, text: "Password")
                    .frame(width: UIScreen.main.bounds.width/1.15, height: UIScreen.main.bounds.height/17)
                Spacer().frame(height:30)
                
                GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .light, style: .icon, state: .normal), action:{
                    Task{
                        try await viewModel.signInGoogle()
                    }
                })
                
                NavigationLink(destination: HomeView(), isActive: $showHomeScreen, label: {EmptyView()})
                
                .cornerRadius(6)
                .shadow(color: Color.black.opacity(1), radius: 0, x: 3, y: 3)
                Spacer().frame(height:30)
                CustomButton(text: "Login")
                    .frame(width: 95.0, height: 30)
                    .onTapGesture {
                        viewModel.login(){success in
                            if (success) {
                                showHomeScreen = true
                            }
                        }
                        print("Login Button Tapped")
                        
                    }
                
                Spacer()
                
                NavigationLink(destination: RegisterView(), label: {
                    
                    Text("Create Your Account")
                        .padding(.all, 30)
                        .bold()
                        .font(.system(size: 20))
                        .shadow(color: .black, radius: 1, x: 1,y: 1)
                    
                })
                .foregroundColor(.black)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    LoginView()
}


