//
//  RegisterView.swift
//  split
//
//  Created by Zawiyar on 04/10/2023.
//

import SwiftUI

struct RegisterView: View {
        @State var username = ""
        @State var password = ""
        @State var name = ""
        
        
    //    init() {
    //        for family in UIFont.familyNames{
    //            print(family)
    //            for font in UIFont.fontNames(forFamilyName: family){
    //                print(font)
    //            }
    //        }
    //    }
        
        var body: some View {
            VStack{
                Spacer()
                Text("SPLIT")
                    .font(.custom("PressStart2P-Regular", size: 50))
                    .shadow(color: .black, radius: 4, x: 2,y:3)
                Spacer()
    //            Spacer().frame(height: 50)
                CustomTextField(textController: $name, text: "Name")
                    .frame(width: UIScreen.main.bounds.width/1.15, height: UIScreen.main.bounds.height/17)
                Spacer().frame(height:20)
                CustomTextField(textController: $username, text: "Username")
                    .frame(width: UIScreen.main.bounds.width/1.15, height: UIScreen.main.bounds.height/17)
                Spacer().frame(height:20)
                CustomTextField(textController: $password, text: "Password")
                    .frame(width: UIScreen.main.bounds.width/1.15, height: UIScreen.main.bounds.height/17)
                Spacer().frame(height:80)
                CustomButton(text: "Register")
                    .frame(width:UIScreen.main.bounds.width/3.5,height: 30)
                    .onTapGesture {
                        print("Login Button Tapped")
                    }
                
                Spacer()
                
                Text("Already have an Account")
                    .padding(.all, 30)
                    .bold()
                    .font(.system(size: 20))
                    .shadow(color: .black, radius: 0.5, x: 1,y: 2)
                    .onTapGesture {
                        print("Create Button Tapped")
                    }
            }
        }
}

#Preview {
    RegisterView()
}
