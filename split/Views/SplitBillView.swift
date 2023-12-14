//
//  SplitBillView.swift
//  split
//
//  Created by Zawiyar on 04/10/2023.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift


struct CircularShadowButton: View {
    var icon:String
    
    var body: some View {
        
        Circle()
            .frame(width: 45)
            
            .foregroundColor(.white)
            .shadow(color: .black, radius: 0, x: 6,y: 5)
            .overlay(Circle().stroke(Color.black, lineWidth: 2))
            .overlay(
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    
                
            )
            
    }
}

struct SliderBar: View {
    @Binding var Value: Double

    var body: some View {
        VStack {
            Slider(value: $Value, in: 0...100, step: 10)
                .accentColor(.yellow)
            Spacer()
        }
        .padding()
    }
}


struct PaymentInfoCard: View {
    @Binding var value: Double
    @State var amount: Int = 0
    @Binding var name: String
    
    @EnvironmentObject var SplitVM: SplitBillViewVM
    var body: some View {
            ZStack(alignment: .topLeading){
                RoundedRectangle(cornerRadius: 25 )
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 1, x: 6,y: 6)
                    .overlay(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).stroke(.black, lineWidth: 4))
                    .frame(height: UIScreen.main.bounds.height/5.9)
                VStack(alignment:.leading){
                    HStack(spacing:14){
                        Circle()
                            .shadow(color:.black, radius: 1,x:4,y:4)
                            .frame(width:50)
                            .foregroundColor(.white)
                            .overlay(
                                Image(systemName: "person.fill")
                            )
                            .overlay(Circle().stroke(Color.black, lineWidth: 2))
                        
                        VStack(alignment:.leading, spacing: 5){
                            Text("\(name) pays")
                                .font(.system(size: 20))
                            Text(String(format: "%.0f%%", value))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .font(.system(size: 25))
                        }
                        
                        Spacer()
                        Text("\(amount)")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 20))
                            .onReceive([amount].publisher, perform: { _ in
                                amount = Int((value/100) * 4000)
                            })
                    }
                    SliderBar(Value: $value)
                }
                .padding()
                
            }
    }
}


struct SwipeToBar:View {
    func dragEnded(){
        print("drag ended function fired")
        self.isNavigationActive = true
        print(isNavigationActive)
    }
    @StateObject var vmSplit = SplitBillViewVM()
    @EnvironmentObject var participantVM: AddParticipantViewVM
    @State private var isNavigationActive = false
    @EnvironmentObject var expenseVM:AddExpenseViewVM
    @State var offset: CGSize = .zero
    @Binding var arrayValues: [Double]
    @State private var isAnimating = false
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
//        Text("\(offset.width)")
        let color = Color(red: offset.width < 80 ? 1 : 0, green: offset.width < 80 ? 1 : Double((offset.width + screenWidth/2) / screenWidth), blue: offset.width < 80 ? 1 : 0)
        
        ZStack(alignment: .leading){
            Capsule()
                .frame(width:UIScreen.main.bounds.width/1.2, height: 50)
                .background(Capsule().stroke(.black, lineWidth:5))
                .foregroundColor(color)
                .padding([.horizontal], 10)
                .shadow(color: .black, radius: 1, x: 5,y: 5)
            
            HStack{
                
                CircularShadowButton(icon: "chevron.forward")
                    .padding()
                    .offset(offset)
                    .gesture(
                        DragGesture()
                            .onChanged{ value in
                                withAnimation(.smooth()) {
                                    offset.width = value.translation.width
                                }
                            }
                            .onEnded{ value in
                                withAnimation(.smooth()){
                                    offset = .zero
                                    vmSplit.createExpenseEntry(percentages: arrayValues, total_amount: Int(expenseVM.totalString) ?? 0, id: participantVM.selectedParticipants)
                                    
                                    
                                    
                                    if let currentUserUID = Auth.auth().currentUser?.email {
                                        print(vmSplit.fetchUser(email: currentUserUID) { user in
                                            if let user = user {
                                                // Do something with the user
                                                print(user)
                                            } else {
                                                // Handle the case where user data is not found or an error occurs
                                                print("User not found or error occurred.")
                                            }
                                        })
                                    }
                                    
                                    if let currentUserUID = Auth.auth().currentUser?.email {
                                        print(vmSplit.sentBill(email: currentUserUID, friends: participantVM.selectedParticipants) { user in
                                            if let user = user {
                                                // Do something with the user
                                                print(user)
                                            } else {
                                                // Handle the case where user data is not found or an error occurs
                                                print("error 404")
                                            }
                                        })
                                    }
                                    
                                    if let currentUserUID = Auth.auth().currentUser?.email {
                                        print(vmSplit.receiveBill( friendsUID: participantVM.selectedParticipants) { user in
                                            if let user = user {
                                                // Do something with the user
                                                print("useer \(user)")
                                            } else {
                                                // Handle the case where user data is not found or an error occurs
                                                print("error char so char")
                                            }
                                        })
                                    }

                                    
                                    print(vmSplit.calculateAmounts(percentages: arrayValues, total_amount: 4000))
                                    self.isNavigationActive = true
//                                    dragEnded()
                                }
                                
                            }
                    )
                
//                Text("\(arrayValues[1])")
//                    .mask(
//                        GeometryReader { geometry in
//                            LinearGradient(
//                                gradient: Gradient(colors: [Color.white.opacity(0.5), Color.white, Color.white.opacity(0.5)]),
//                                startPoint: .leading,
//                                endPoint: .trailing
//                            )
//                            .frame(width: geometry.size.width, height: 70)
//                            .offset(x: isAnimating ? geometry.size.width : -geometry.size.width)
//                        }
//                    )
//                    .onAppear {
//                        withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: false)) {
//                            isAnimating = true
//                        }
//                    }

                    
                
//                Text("Send the bill >>>")
//                    .mask(
//                        LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.5), Color.white, Color.white.opacity(0.5)]), startPoint: .leading, endPoint: .trailing)
//                            .frame(width: 200, height: 70)
//                            .offset(x: isAnimating ? 200 : -200)
//                    )
//                    .onAppear {
//                        withAnimation(Animation.easeInOut (duration: 5).repeatForever(autoreverses: false)) {
//                            isAnimating = true
//                        }
//                    }
            }
            
        }
        
    }
}




struct SplitBillView: View {
    //@state ArraySliders: [particpantds +1]
//    @Binding var selectedParticipants: [User]
//    @StateObject var participantVM = AddParticipantViewVM()
    @EnvironmentObject var participantVM: AddParticipantViewVM
    @EnvironmentObject var expenseVM:AddExpenseViewVM
    @State private var arrayValues: [Double] = []
    
    
        //    @State var arrayValues = [0.0,0.0,0.0,0.0,0.0]
    var body: some View {
        NavigationView{
            @State var sum = arrayValues.reduce(0, +)
            VStack(alignment: .leading, spacing: 5){
                Spacer()
                CircularShadowButton(icon: "chevron.backward")
                Spacer().frame(height:10)
                
                HStack{
                    Text("Split the bill")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(.system(size: 25))
                    Spacer()
                    Text("Rs. \(expenseVM.totalString)")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(.system(size: 25))
                }
                
                Text("\(sum)")
                    .font(.system(size: 20))
                    .padding([.horizontal], 10)
                
                Spacer().frame(height: 10)
                ScrollView{
                    VStack(spacing:2){
                        
                        ForEach(arrayValues.indices, id: \.self){index in
                            PaymentInfoCard(value: $arrayValues[index], name: $participantVM.selectedParticipants[index].name)
                        }
                    }
                    .padding(.horizontal,6)
                }
                
                
                
                
                
                
                Spacer()
                
                NavigationLink(destination: HomeView(), label: {
                    SwipeToBar(arrayValues:$arrayValues)
                        .padding(.bottom, 30)
                })
                
                
                .foregroundColor(.black)
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
        }
        .onAppear {
                    // Initialize arrayValues based on selectedParticipants
            print("Selected participants changed. New count: \(participantVM.selectedParticipants)")
            
            print("\(arrayValues)")
            
                    arrayValues = Array(repeating: 0.0, count: participantVM.selectedParticipants.count)
                }
        .onTapGesture {
            print(arrayValues)
        }
        .environmentObject(participantVM)
        .navigationBarBackButtonHidden(true)
    }
    
}

#Preview {
    SplitBillView()
        .environment(AddParticipantViewVM())
        .environment(SplitBillViewVM())
        .environment(AddExpenseViewVM())
}
