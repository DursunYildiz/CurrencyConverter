//
//  ContentViewModel.swift
//  CurrencyConverter
//
//  Created by A101Mac on 20.01.2022.
//

import SwiftUI
import Combine
import CoreData
class ContentViewModel: ObservableObject {
  
    @Published var selectedName : String = ""
    @Published var selectedDouble : Double = 0
   
    var context : NSManagedObjectContext
    var coreDataRepository : CoreDataRepository<Item>
    init(){
        context =  CoreManager(dbName: "CurrencyConverter").persistentContainer.viewContext
        coreDataRepository =   CoreDataRepository<Item>(managedObjectContext: context)
    
    }
    func saveDataForDB () {
        
         let name = coreDataRepository.get(predicate:  NSPredicate(format: "name ==[c] %@",selectedName), sortDescriptors: nil)
        
        switch name {
        case .success(let items) :
          
            if items.isEmpty {
                let item = coreDataRepository.create()
                
                
                switch item {
                case .success(let item):
                    item.name = selectedName
                    item.price = selectedDouble
                   try? context.save()
                case .failure(let error):
                    print(error)
                    
                }
            }
            
        case .failure(_) :
            print("ter")
           
        }
      
    }
    func getDataForDB () -> [Item] {
      

        let items = coreDataRepository.get(predicate: nil, sortDescriptors: nil)
        
        switch items {
        case .success(let items) :
          
            return items
            
        case .failure(_) :
            
            return []
        }
    
    }
}


