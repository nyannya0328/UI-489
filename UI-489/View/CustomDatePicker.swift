//
//  CustomDatePicker.swift
//  UI-489
//
//  Created by nyannyan0328 on 2022/03/03.
//

import SwiftUI

struct CustomDatePicker: View {
    
    @Binding var currentDate : Date
    
    @State var animateValue : [Bool] = Array(repeating: false, count: 3)
    @State var currentMonth : Int = 0
    var body: some View {
        VStack(spacing:30){
            
            
            HStack(spacing:15){
                
                
                Button {
                    
                    currentMonth -= 1
                    
                } label: {
                    
                    Image(systemName: "arrow.left")
                    
                       
                }
                
              
                
                
                Text(extracteDate()[0] + " " + extracteDate()[1])
                    .font(.callout.weight(.semibold))
                
                
                
                Button {
                    
                    
                    currentMonth += 1
                    
                } label: {
                    
                    Image(systemName: "arrow.right")
                       
                }
                
                .font(.callout.weight(.semibold))

                
            }
            .foregroundColor(.white)
            .padding(.horizontal)
            
            Rectangle()
                .fill(.white.opacity(0.4))
                .frame(width:animateValue[0] ? nil : 0, height: 1)
                .padding(.vertical)
                .frame(maxWidth:.infinity,alignment: .leading)
            
            
            
            if animateValue[0]{
                
                
                let columns = Array(repeating: GridItem(.flexible(),spacing: 10), count: 7)
                
                LazyVGrid(columns: columns,spacing: 15) {
                    
                    
                    ForEach(0..<extractDateValue().count,id:\.self){index in
                        
                        let value = extractDateValue()[index]
                        
                        
                        pickeCardView(value: value, index: index, currentDate: $currentDate,isFinished: $animateValue[1])
                            .onTapGesture {
                                
                                
                                currentDate = value.date
                            }
                       
                    }
                    
                    
                }
                
   }
            
            else{
                
                let columns = Array(repeating: GridItem(.flexible(),spacing: 10), count: 7)
                
                LazyVGrid(columns: columns,spacing: 15) {
                    
                    
                    ForEach(0..<extractDateValue().count,id:\.self){index in
                        
                        let value = extractDateValue()[index]
                        
                        
                        pickeCardView(value: value, index: index, currentDate: $currentDate,isFinished: $animateValue[1])
                            .onTapGesture {
                                
                                
                                currentDate = value.date
                            }
                       
                    }
                    
                    
                }
                .opacity(0)
                
                
                
                
            }
            
            
                
            
            
            
            
            
        }
        .padding()
        .onChange(of: currentMonth, perform: { newValue in
            
            currentDate = getCurrentMonth()
            
        })
        
        .onAppear {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                
                
                withAnimation(.easeInOut(duration: 0.3)){
                    
                    
                    animateValue[0] = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    
                    
                    
                    animateValue[1] = true
                }
                
                
                
            }
            
        }
        
    }
    
    func extracteDate()->[String]{
        
        let calendar = Calendar.current
        
        let month = calendar.component(.month, from: currentDate) - 1
        let year = calendar.component(.year, from: currentDate)
        
        return ["\(year)",calendar.monthSymbols[month]]
    }
    
    func getCurrentMonth()->Date{
        
        
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else{
            
            return Date()
            
        }
        
        return currentMonth
        
        
        
    }
    
  func extractDateValue()->[DateValue]{

        let calendar = Calendar.current

        let currentMonth = getCurrentMonth()

        var days = currentMonth.getAllDates().compactMap { date -> DateValue in

            let day = calendar.component(.day, from: date)

            return DateValue(day: day, date: date)


        }

        let firstWeek = calendar.component(.weekday, from: days.first!.date)


        for _ in 0..<firstWeek - 1{


            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }

        return days
    }
    
    
 
}

func isSampleDay(date1 : Date,date2:Date) ->Bool{
    
    
    let calendar = Calendar.current
    
    return calendar.isDate(date1, inSameDayAs: date2)
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct pickeCardView : View{
    var value : DateValue
    var index : Int
    
    @Binding var currentDate : Date
    
  @State var showView : Bool = false
    
 @Binding var isFinished : Bool
    
    
    var body: some View{
        
        VStack{
            
            if value.day != -1{
                
                
                Text("\(value.day)")
                    .font(.callout.weight(.bold))
                    .foregroundColor(isSampleDay(date1: value.date, date2: currentDate) ? .black : .white)
                    .frame(maxWidth:.infinity)
            }
            
            
            
        }
     
        .background{
            
            
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(.white)
                .padding(.vertical,-5)
                .padding(.horizontal,-5)
                .opacity(isSampleDay(date1: currentDate, date2: value.date) ? 1 : 0)
            
                
            
            
            
            
        }
        .opacity(showView ? 1 : 0)
    
        .onAppear {
            
            if isFinished{showView = true}
            withAnimation(.spring().delay(Double(index) * 0.03)){
                
                
                showView = true
            }
            
        }
    }
    
}

extension Date{
    
    func getAllDates()->[Date]{
        
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for:startDate)!
        
        return range.compactMap({ day -> Date in
            
            
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        })
        
    }
    
    
}
