//
//  SelectViewModel.swift
//  CurrencyConverter
//
//  Created by A101Mac on 20.01.2022.
//

import Foundation
import Combine
import SwiftUI
class SelectViewModel : ObservableObject {

    
    @Published var data : [String:Double] = [:]
    private var cancellables = Set<AnyCancellable>()
    @Published var isShowLoadingView: Bool = false
    @Published var isShowAlertOfValidation: Bool = false
    @Published var errorMessage: String = ""

func getData () {
    isShowLoadingView = false
    NetworkManager.shared.getData(endpoint: .endpoint, id: nil, type: .CurrencyModel, baseUrl: .base).sink { response in
        switch response {
            
        case .finished:
     
         print("")
        case .failure(let err):
            self.errorMessage = err.localizedDescription
            self.isShowAlertOfValidation = true
            self.isShowLoadingView = false
        }
    } receiveValue: { (response: CurrencyModel) in
    
        self.data = response.rates ?? [:]
    }
    .store(in: &cancellables)


}
    func ShowAlertOfValidation(message: String) -> Alert {
        return Alert(title: Text("Hata"), message: Text(message), dismissButton: .default(Text("Tamam")))
    }
}
