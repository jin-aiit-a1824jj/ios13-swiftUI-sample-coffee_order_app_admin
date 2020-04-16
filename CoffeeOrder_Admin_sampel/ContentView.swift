//
//  ContentView.swift
//  CoffeeOrder_Admin_sampel
//
//  Created by JONGWOO JIN on 2020/04/15.
//  Copyright © 2020 JONGWOO JIN. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var orderListener = OrderListener()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Active Order"), content: {
                    ForEach(self.orderListener.activeOrders ?? [ ] ) { order in
                        NavigationLink(destination: OrderDetailView(order :order), label: {
                            HStack{
                                Text(order.customerName)
                                Spacer()
                                Text("$ \(order.amount.clean)")
                            }
                        })
                    }
                })//Section
                
                Section(header: Text("Completed Order"), content: {
                    ForEach(self.orderListener.completedOrders ?? [ ] ) { order in
                        NavigationLink(destination: OrderDetailView(order :order), label: {
                            HStack{
                                Text(order.customerName)
                                Spacer()
                                Text("\(order.amount.clean)")
                            }
                        })
                    }
                })//Section
                
            }//List
            .navigationBarTitle("Orders")
        }//NavigationView
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
