//
//  Home.swift
//  UI-489
//
//  Created by nyannyan0328 on 2022/03/03.
//

import SwiftUI

struct Home: View {
    
    @State var animateValue : [Bool] = Array(repeating: false, count: 3)
    
    @Namespace var animation
    
    @State var currentDate : Date = Date()
    var body: some View {
        ZStack{
            
            if !animateValue[0]{
                
                RoundedRectangle(cornerRadius: animateValue[0] ? 30 : 0, style: .continuous)
                    .fill(Color("Purple"))
                    .matchedGeometryEffect(id: "DATEVIE", in: animation)
                    .ignoresSafeArea()
                    

                Image("Logo")
                    .scaleEffect(animateValue[0] ? 0.25 : 1)
                    .matchedGeometryEffect(id: "Splash", in: animation)
                
            }

                
                if animateValue[0]{
                    
                    
                    VStack{


                        Button {

                        } label: {


                            Image(systemName: "rectangle.leadinghalf.inset.filled")
                                .font(.title3)
                                .foregroundColor(.black)

                        }
                        .frame(maxWidth:.infinity,alignment: .trailing)
                        .overlay {

                            Text("All debts")
                        }
                        .padding(.bottom,20)
                        
                        
                        CustomDatePicker(currentDate: $currentDate)
                            .overlay(alignment: .topLeading, content: {
                                
                                Image("Logo")
                                    .scaleEffect(0.25)
                                    .matchedGeometryEffect(id: "Splash", in: animation)
                                    .offset(x: -10, y: -20)
                                
                            })
                            .background{
                        
                        
                        
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .fill(Color("Purple"))
                            .matchedGeometryEffect(id: "DATEVIE", in: animation)
                        
                            }
                        
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            
                            VStack(spacing:20){
                                
                                ForEach(users){user in
                                    
                                    UserCardView(user: user, index:getIndex(user: user) )
                                    
                                    
                                    
                                    
                                }
                            }
                            .padding(.top,20)
                            
                            
                        }
                        
                        

                        
                        

                    }
                    .padding([.horizontal,.bottom])
                  
                    
                }
                
            
              
        }
        
       
        .onAppear {
            
            
            startAnimation()
            
            
            
        }
    }
    
    func getIndex(user : User)->Int{
        
        return users.firstIndex { currentUser in
            user.id == currentUser.id
        } ?? 0
    }
    func startAnimation(){
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            
        
            withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.7, blendDuration: 0.8)){
                
                animateValue[0] = true
                
            }
                
            
           
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                
                
                animateValue[1] = true
                
//                withAnimation(.easeInOut(duration: 0.5)){
//
//                    animateValue[2] = true
//                }
                
            }
            
            
            
        }
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
