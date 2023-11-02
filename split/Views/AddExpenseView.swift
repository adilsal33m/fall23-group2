//
//  AddExpenseView.swift
//  split
//
//  Created by Zawiyar on 04/10/2023.
//

import SwiftUI

struct CustomTextField2: View{
    @Binding var textController: String
    var text: String
    var formatter: NumberFormatter
    var body: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color.white)
                .shadow(color: Color.black.opacity(1), radius: 0, x: 6, y: 6)
            
            TextField(text, text: $textController)
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
    var body: some View {
        VStack {
            Circle()
                //.fixedSize()
                .shadow(color:.black, radius: 1,x:4,y:4)
                .frame(width:50)
                .foregroundColor(.white)
                .overlay(
                    Image(systemName: "person.fill")
                )
            .overlay(Circle().stroke(Color.black, lineWidth: 2))
            Text(Name).fontWeight(.medium).multilineTextAlignment(.center).lineLimit(2)
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
    @State private var total = 0
    
    let ConvertToNumber: NumberFormatter = {
            let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
            return formatter
    }()

    @State var BillDesc: String = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            //Spacer().frame(height:10)

            HStack{
                CircularShadowButton(icon: "chevron.backward")
                Spacer()
                Text("Add Expense")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 25))
                Spacer()
            }
            
            CustomTextField(textController: $BillDesc, text: "Bill Description")
                .frame(width: UIScreen.main.bounds.width/1.15, height: UIScreen.main.bounds.height/17)
            Spacer().frame(height:5)
            HStack {
                Text("Total Bill").font(.title2).lineLimit(1).fontWeight(.bold)
                Spacer().frame(width:55)
                CustomTextField2(textController: $BillDesc, text: "Rs. 00.00", formatter: ConvertToNumber)
                    .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/17)
            }
            Spacer().frame(height:1)
            Divider().frame(height:3).overlay(.black)
            Spacer().frame(height:1)
            Text("Split With:").font(.title2).lineLimit(1).fontWeight(.bold)
            //Spacer().frame(height:1)
            HStack(alignment: .top, spacing:15){
                CustomPerson(Name:"You")
                CustomPerson(Name:"Friend 1")
                CustomPerson(Name:"Friend 2")
                //CustomPerson(Name:"Friend's Name")
                CustomAddPersonButton()
            }
            Spacer()
            Text("Paid by:").font(.title2).lineLimit(1).fontWeight(.bold)
            HStack(alignment: .top, spacing:15){
                CustomPerson(Name:"You")
                CustomPerson(Name:"Friend 1")
                CustomPerson(Name:"Friend 2")
            }
            Spacer()
            CustomButton(text: "Split Now").frame(height:50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
    }
}

#Preview {
    AddExpenseView()
}

