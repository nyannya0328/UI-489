//
//  UserCardView.swift
//  UI-489
//
//  Created by nyannyan0328 on 2022/03/03.
//

import SwiftUI


struct UserCardView: View {
    var user : User
    var index : Int
    @State var showView : Bool = false
    var body: some View {
        HStack{
            
            Image(user.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .cornerRadius(10)
            
            
            VStack(alignment: .leading, spacing: 15) {
                
                
                Text(user.name)
                    .font(.title.weight(.semibold))
                    .foregroundColor(.black)
                
                
                Text(user.type)
                    .font(.title3)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth:.infinity,alignment: .leading)
            
            
            Text(user.amount)
                .font(.title)
                .foregroundColor(.gray)
            
            
        }
       
        .padding(.horizontal)
        .padding(.vertical,8)
        .background(
        
        
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .stroke(.gray.opacity(0.2),lineWidth: 2)
        
        )
        .offset(y:index > 8 ? 0 : showView ? 0 : 500)
        .onAppear {
            
            if index > 8 {return}
            
            withAnimation(.easeInOut(duration: 0.3).delay(Double(index) * 0.1)){
                
                
                showView = true
            }
        }
    }
}

struct UserCardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
