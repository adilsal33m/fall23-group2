//
//  AddParticipants.swift
//  split
//
//  Created by Zawiyar on 04/10/2023.
//

import SwiftUI

struct CustomFriendCard: View {
    @State private var isSelected = false
    @State var Name:String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15.0)
                .frame(height: UIScreen.main.bounds.height/10)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 1, x: 3.5, y:3.5)
                .overlay(RoundedRectangle(cornerRadius: 15.0).stroke(.black, lineWidth: 2))
            
            HStack(){
                
                CustomPerson(Name: "")
                Spacer().frame(width: 20)
                Text("\(Name)")
                    .padding(.bottom,10)
                    .bold()
                
                Spacer()
                isSelected ? Image(systemName: "checkmark.circle") : Image(systemName: "circle.dashed")
            }
            .padding(.horizontal,20)

        }
        .onTapGesture {
            if (isSelected == true){
                self.isSelected = false
            }else{
                self.isSelected = true
            }
            
        }
        
    }
}

struct AddParticipants: View {
    @StateObject var viewModel = AddParticipantViewVM()
    var body: some View {
        VStack(alignment: .leading, content: {
            HStack{
                Text("Add Participants")
                    .bold()
                    .font(/@START_MENU_TOKEN@/.title/@END_MENU_TOKEN@/)
                Spacer()
                Text("Done")
                    .bold()
            }
            ZStack{
                RoundedRectangle(cornerRadius: 15)
                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                    .frame(height: UIScreen.main.bounds.height/9)
                    .padding()
                HStack(spacing:10){
                    CustomPerson(Name: "zawiyar")
                    CustomPerson(Name: "dua")
                    CustomPerson(Name: "madiha")
                    
                }
            }
            
            CustomTextField(textController: $viewModel.search, text: "Search")
                .frame(width: UIScreen.main.bounds.width/1.15, height: UIScreen.main.bounds.height/17)
            
            Text("Friends")
                .font(.title)
                .bold()
                .padding()
        
            
            Spacer().frame(height:30)
            
            ScrollView{
                VStack(spacing: 20){
                    ForEach(viewModel.users, id: \.id){ user in
                        CustomFriendCard(Name: user.name)
                    
                    }
                }
                .padding(.horizontal,10)
                .onAppear{
                    viewModel.fetchUsers()
                }
            }
            
            
            
            
                    
        })
        .padding()
    }
}

#Preview {
    AddParticipants()
}
