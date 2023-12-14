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
    var id:UUID
    var email:String
    @Binding var selectedParticipants:[User]
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
            self.isSelected.toggle()
            if (isSelected == true){
                selectedParticipants.append(User(id: id, email: email, name: Name))
            }else{
                selectedParticipants.removeAll{$0.id == id}
            }
            
        }
        
    }
}

struct AddParticipants: View {
//    @StateObject var viewModel = AddParticipantViewVM()
    @EnvironmentObject var viewModel: AddParticipantViewVM

    var body: some View {
        NavigationView{
            VStack(alignment: .leading, content: {
                HStack{
                    Text("Add Participants")
                        .bold()
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    Spacer()
                    NavigationLink(destination: SplitBillView(), label: {
                        Text("Done")
                            .bold()

                    })
                    .foregroundColor(.black)
                                    }
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                        .frame(height: UIScreen.main.bounds.height/7)
                        .padding()
                    HStack(spacing:10){
                        //                    CustomPerson(Name: "zawiyar")
                        //                    CustomPerson(Name: "dua")
                        //                    CustomPerson(Name: "madiha")
                        
                        ForEach(viewModel.selectedParticipants, id: \.id){ user in
                            CustomPerson(Name: user.name)
                        }
                        
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
                            CustomFriendCard(Name: user.name, id: user.id,email: user.email, selectedParticipants: $viewModel.selectedParticipants)
//                                .onTapGesture {
//                                    viewModel.addUserToSelection(user: user)
//                                    viewModel.printU()
//                                }
                            
                        }
                    }
                    .padding(.horizontal,10)
                    .onAppear{
                        viewModel.fetchUsers()
                    }
                }
                
                
                
                
                
            })
            .padding()
//            .environmentObject(viewModel)
        }
        .navigationBarBackButtonHidden(true)
//        .environmentObject(viewModel)
    }
}

#Preview {
    AddParticipants()
        .environment(AddParticipantViewVM())
}
