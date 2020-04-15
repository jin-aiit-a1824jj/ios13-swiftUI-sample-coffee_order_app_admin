//
//  OrderListener.swift
//  CoffeeOrder_Admin_sampel
//
//  Created by JONGWOO JIN on 2020/04/15.
//  Copyright © 2020 JONGWOO JIN. All rights reserved.
//

import Foundation
import Firebase

class OrderListener: ObservableObject {
    
    @Published var activeOrders: [Order]!
    @Published var completedOrders: [Order]!
    
    init(){
        downloadBasket()
    }
    
    func downloadBasket() {
        
        FirebaseReference(.Order).addSnapshotListener{ (snapshot, error) in
            guard let snapshot = snapshot else { return}
            
            self.activeOrders = []
            self.completedOrders = []
            
            for order in snapshot.documents {
                let orderData = order.data()
                getDrinksFromFirestore(withIds: orderData[kDRINKIDS] as? [String] ?? []){ (allDrinks) in
                    let order = Order()
                    order.customerName = orderData[kCUSTOMERNAME] as? String ?? ""
                    order.id = orderData[kID] as? String ?? ""
                    order.orderItems = allDrinks
                    order.amount = orderData[kAMOUNT] as? Double ?? 0.0
                    order.customerId = orderData[kCUSTOMERID] as? String ?? ""
                    order.isCompleted = orderData[kISCOMPLETED] as? Bool ?? false
                    
                    if order.isCompleted {
                        self.completedOrders.append(order)
                    }else {
                        self.activeOrders.append(order)
                    }
                    
                }
            }
            
            
        }
    }
    
}

func getDrinksFromFirestore(withIds: [String], completion: @escaping (_ drinkArray: [Drink]) -> Void) {
    
    var count = 0
    var drinkArray: [Drink] = []
    
    if withIds.count == 0 {
        completion(drinkArray)
        return
    }
    for drinkId in withIds {
        FirebaseReference(.Menu).whereField(kID, isEqualTo: drinkId).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else {return}
            if !snapshot.isEmpty {
                
                let drinkData = snapshot.documents.first!
                drinkArray.append(Drink(id: drinkData[kID] as? String ?? UUID().uuidString,
                                        name: drinkData[kNAME] as? String ?? "unknown",
                                        imageName: drinkData[kIMAGENAME] as? String ?? "unknown",
                                        category: Category(rawValue: drinkData[kCATEGORY] as? String ?? "cold") ?? .cold,
                                        description:drinkData[kDESCRIPTION] as? String ?? "Description is missing" ,
                                        price:  drinkData[kPRICE] as? Double ?? 0.0))
                count += 1
                
            }else {
                print("have no drink")
                completion(drinkArray)
            }
            
            if count == withIds.count {
                completion(drinkArray)
            }
            
        }
    }
    
    
}
