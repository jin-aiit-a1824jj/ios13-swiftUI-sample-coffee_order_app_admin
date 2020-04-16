//
//  OrderDetailView.swift
//  CoffeeOrder_Admin_sampel
//
//  Created by JONGWOO JIN on 2020/04/15.
//  Copyright © 2020 JONGWOO JIN. All rights reserved.
//

import SwiftUI

struct OrderDetailView: View {
    
    var order: Order
    
    var body: some View {
        
        VStack {
            
            List {
                
                Section(header: Text("Customer"), content: {
                    Text(order.customerName)
                })//Section
                
                Section(header: Text("Order Item"), content: {
                    ForEach(self.order.orderItems){ drink in
                        HStack {
                            Text(drink.name)
                            Spacer()
                            Text("$ \(drink.price.clean)")
                        }
                    }
                })//Section
                
            }//List
            
        }//VStack
            .navigationBarTitle("Order", displayMode: .inline)
    }
    
}

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailView(order: Order())
    }
}