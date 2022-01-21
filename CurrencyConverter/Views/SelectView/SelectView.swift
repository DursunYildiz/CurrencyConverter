//
//  SelectView.swift
//  CurrencyConverter
//
//  Created by A101Mac on 20.01.2022.
//

import SwiftUI

struct SelectView: View {
    @ObservedObject var selectViewModel : SelectViewModel = SelectViewModel()
    @State var selectedName : String = ""
    @State var selectedDouble : Double = 0
    @EnvironmentObject  var contentViewModel : ContentViewModel
    @State var searchText : String = ""
    @Binding var isShow : Bool
    
    init(isShow : Binding<Bool>){
        _isShow = isShow
        selectViewModel.getData()
    }
    var body: some View {
        NavigationView {
            ZStack {
                LoadingView(isShowing: $selectViewModel.isShowLoadingView){
                    List(0..<selectViewModel.data.count , id:\.self) { index in
                    
                        Button {
                            selectedName = Array(selectViewModel.data)[index].key
                          selectedDouble = Array(selectViewModel.data)[index].value
                        } label: {
                            HStack {
                                Text(Array(selectViewModel.data)[index].key).foregroundColor(.black)
                                Spacer()
                                if Array(selectViewModel.data)[index].key ==  selectedName  {
                                    Spacer()
                                    Image(systemName: "checkmark").foregroundColor(.black)
                                }
                            }
                        }

                        
                        
                    }
                    .navigationTitle(Text("Para Birimi Seçiniz"))
                    .onDisappear {
                        contentViewModel.selectedName = selectedName
                        contentViewModel.selectedDouble = selectedDouble
                    }
                    .navigationBarItems( trailing:
                                            Button(action: {
                        isShow.toggle()
                        
                    }, label: {
                        Text("Done")
                    })
                )
                }
                .alert(isPresented: $selectViewModel.isShowAlertOfValidation) {
                    selectViewModel.ShowAlertOfValidation(message: selectViewModel.errorMessage)
                }
            }
          
        }
     
    }
}

struct SelectView_Previews: PreviewProvider {
    static var previews: some View {
        SelectView(isShow: .constant(true))
    }
}
struct MyCostumSearchBar : View {
    @Binding var searchText : String
    @State var showCancelButton : Bool = false
    var body: some View {
        HStack {
                          HStack {
                              Image(systemName: "magnifyingglass")

                              TextField("Arama", text: $searchText, onEditingChanged: { isEditing in
                                  self.showCancelButton = true
                              }, onCommit: {
                                  print("onCommit")
                              }).foregroundColor(.primary)

                              Button(action: {
                                  self.searchText = ""
                              }) {
                                  Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                              }
                          }
                          .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                          .foregroundColor(.secondary)
                          .background(Color(.secondarySystemBackground))
                          .cornerRadius(10.0)

                          if showCancelButton  {
                              Button("Cancel") {
                                      UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                                      self.searchText = ""
                                      self.showCancelButton = false
                              }
                              .foregroundColor(Color(.systemBlue))
                          }
                      }
                      .padding(.horizontal)

    }
}
