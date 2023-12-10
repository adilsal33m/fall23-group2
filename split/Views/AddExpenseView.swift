//
//  AddExpenseView.swift
//  split
//
//  Created by Zawiyar on 04/10/2023.
//

import SwiftUI

struct CustomNumberField: View{
    @Binding var textController: String
    var text: String
    var body: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color.white)
                .shadow(color: Color.black.opacity(1), radius: 0, x: 6, y: 6)

            TextField(text, text: $textController).keyboardType(.decimalPad)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 10, trailing: 16))
                .font(.largeTitle).bold()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 3)
                )
        }
    }
}



struct CustomPerson: View {
    var Name: String
    @State var isSelected = false
    var body: some View {
        VStack {
            Circle()
                //.fixedSize()
                .shadow(color:.black, radius: 1,x:4,y:4)
                .frame(width:50)
                .foregroundColor(.white)
                .overlay(
                    isSelected ? Image(systemName:"checkmark.circle.fill"):Image(systemName: "person.fill")
                )
            .overlay(Circle().stroke(Color.black, lineWidth: 2))
            Text(Name).frame(width:50).fontWeight(.medium).multilineTextAlignment(.center).lineLimit(2)
        }
        .onTapGesture {
            if (isSelected == false){
                isSelected = true
            }else{
                isSelected = false
            }
        }
    }
    
}

struct CustomAddPersonButton: View{
    
    var body: some View {
        
        VStack{
            Circle()
                //.fixedSize()
                .shadow(color:.black, radius: 1,x:4,y:4)
                .frame(width:50)
                .foregroundColor(.white)
                .overlay(
                    Image(systemName: "plus")
                )
            .overlay(Circle().stroke(Color.black, lineWidth: 2))
            Text("Add").fontWeight(.medium)
        }.onTapGesture {
            //enter code here!!!
        }
        
    }
}

struct AddExpenseView: View {
    @EnvironmentObject var viewModel: AddExpenseViewVM
    @State var friend_selected = []
//    @StateObject var viewModel = AddExpenseViewVM()
//    @EnvironmentObject var PviewModel: AddParticipantViewVM
    var body: some View {
        NavigationView{
            VStack(alignment: .leading, spacing: 20){
                //Spacer().frame(height:10)
                
                HStack{
                    NavigationLink(destination: HomeView(), label: {
                        CircularShadowButton(icon: "chevron.backward")
                    })
                    
                    Spacer()
                    Text("Add Expense")
                        .fontWeight(.bold)
                        .font(.system(size: 25))
                    Spacer()
                }
                
                CustomTextField(textController: $viewModel.BillDesc, text: "Bill Description")
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/17)//.padding(.horizontal,30)
                
                Spacer().frame(height:5)
                
                HStack {
                    Text("Total Bill").font(.title2).lineLimit(1).fontWeight(.bold)
                    Spacer()//.frame(width:55)
                    CustomNumberField(textController: $viewModel.totalString, text: "Rs. 00.00")
                        .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/17).frame( alignment: .topTrailing)
                }
                
                Spacer().frame(height:1)
                
                Divider().frame(height:3).overlay(.black)
                
                //Spacer().frame(height:1)
                NavigationLink(destination: AddParticipants(), label: {
                    Text("Split With:").font(.title2).lineLimit(1).fontWeight(.bold)
                })
                .foregroundColor(.black)
                
                //Spacer().frame(height:1)
                ScrollView(.horizontal){
                    HStack(alignment: .top, spacing:15){
                        
                        ForEach(viewModel.users, id: \.id){ user in
                            CustomPerson(Name: user.name)
                                .onTapGesture {
                                    
                                }
                        }
                    }
                    //                CustomPerson(Name:"You")
                    //                CustomPerson(Name:"Friend Name")
                    //                CustomPerson(Name:"Friend 2")
                    //CustomPerson(Name:"Friend's Name")
                    CustomAddPersonButton()
                }
                .onAppear{
                    viewModel.fetchUsers()
                }
                Spacer()
                Text("Paid by:").font(.title2).lineLimit(1).fontWeight(.bold)
                HStack(alignment: .top, spacing:15){
                    CustomPerson(Name:"You")
                    CustomPerson(Name:"Friend 1")
                    CustomPerson(Name:"Friend 2")
                }
                Spacer()
                NavigationLink(destination: AddParticipants(), label: {
                    CustomButton(text: "Split Now").frame(height:50)
                })
                .foregroundColor(.black)
                
            }
            .frame( maxHeight: .infinity, alignment: .topLeading)
            
        }
        .navigationBarBackButtonHidden(true)
    }
}
            
#Preview {
    AddExpenseView()
        .environment(AddExpenseViewVM())
}
