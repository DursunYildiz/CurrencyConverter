//
//  ContentView.swift
//  CurrencyConverter
//
//  Created by A101Mac on 20.01.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var contentViewModel : ContentViewModel = ContentViewModel()
    @State var showSheet : Bool = false
    var body: some View {
        ZStack {
            Color.backg.ignoresSafeArea()
            VStack {
                
                RoundedRectangle(cornerRadius: 12)
                     .fill(gradient())
                   
                     .padding()
                     .overlay(
                        VStack {
                            Spacer()
                            Text(contentViewModel.selectedName).font(.largeTitle).foregroundColor(.white)
                            Text(contentViewModel.selectedDouble.description.convertMoney(money: contentViewModel.selectedName)).font(.largeTitle).foregroundColor(.white)
                            
                        Spacer()
                            HStack {
                                Spacer()
                                       Button {
                                           withAnimation {
                                               if contentViewModel.selectedName != "" {
                                                   contentViewModel.saveDataForDB()
                                               }
                                           }
                                       } label: {
                                          Image(systemName: "heart.circle")
                                               .font(.title)
                                               .foregroundColor(.red)
                                       }
                            }
                            .padding(40)
                        }
                        
                     )
                   
                     .frame( height: getRect().height * 0.3)
                
                Button {
                    showSheet.toggle()
                } label: {
                    Text( "Para birimi seç"  )
                }
                
                
                ScrollView(.horizontal){
                    LazyHStack {
                        ForEach(contentViewModel.getDataForDB()) { item in
                            RoundedRectangle(cornerRadius: 12)
                                 .fill(gradient())
                               
                                 .padding()
                                 .overlay(
                                    VStack {
                                       
                                        Text(item.name ?? "").font(.largeTitle).foregroundColor(.white)
                                        Text(item.price.description.convertMoney(money: item.name ?? "")).font(.largeTitle).foregroundColor(.white)
                                        
                                    }
                                    
                                 )
                               
                                 .frame(width:getRect().width * 0.4, height: getRect().height * 0.3)
                        }
                    }
                }
                

            }
        }
        .sheet(isPresented: $showSheet) {
            SelectView(isShow:$showSheet)
                .environmentObject(contentViewModel)
        }
    
      

    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
func gradient () -> LinearGradient{
    return  LinearGradient(gradient: Gradient(colors: [Color(red: 131/255, green: 58/255, blue: 199/255), Color(red: 94/255, green: 63/255, blue: 216/255)]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
    
}
