//
//  SplitBillView.swift
//  split
//
//  Created by Zawiyar on 04/10/2023.
//

import SwiftUI

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
    var body: some View {
        ZStack(alignment: .topLeading){
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
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
                        Text("Zawiyar will pay")
                            .font(.system(size: 20))
                        Text(String(format: "%.0f%%", value))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 25))
                    }
                    
                    Spacer()
                    Text("Rs. 1000")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(.system(size: 20))
                }
                SliderBar(Value: $value)
            }
            .padding()
            
        }
        
    }
}


struct SwipeToBar:View {
    var body: some View {
        ZStack(alignment: .leading){
            Capsule()
                .frame(width:UIScreen.main.bounds.width/1.2, height: 50)
                .background(Capsule().stroke(.black, lineWidth:5))
                .foregroundColor(.white)
                .padding([.horizontal], 10)
                .shadow(color: .black, radius: 1, x: 5,y: 5)
            
            HStack{
                CircularShadowButton(icon: "chevron.forward")
                    .padding()
                
                Text("Send the bill >>>")
            }
            
        }
        
    }
}

// make a single state variable add all the perecentages to the the same variable
// the final variable should be checked, if it equals to 100%, we proceed with the flow
// else a warning message/dialog shows that informs the user


struct SplitBillView: View {
    //@state ArraySliders: [particpantds +1]
    @State var arrayValues = [0.0,0.0,0.0]
        var body: some View {
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
                    Text("Rs. 4000")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(.system(size: 25))
                }
                
                Text("\(sum)")
                    .font(.system(size: 20))
                    .padding([.horizontal], 10)
                
                Spacer().frame(height: 10)
                VStack{
                    
                    ForEach(arrayValues.indices, id: \.self){index in
                        PaymentInfoCard(value: $arrayValues[index])
                    }
//                    PaymentInfoCard(value: $totalValue)
//                    PaymentInfoCard(value: $totalValue1)
//                    PaymentInfoCard(value: $totalValue2)
                }
                
                
                
                
                SwipeToBar()
                    .padding(.bottom, 50)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
    
    }
}

#Preview {
    SplitBillView()
}
