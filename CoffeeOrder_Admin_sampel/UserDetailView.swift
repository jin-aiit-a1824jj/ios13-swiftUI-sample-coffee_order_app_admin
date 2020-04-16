//
//  UserDetailView.swift
//  CoffeeOrder_Admin_sampel
//
//  Created by JONGWOO JIN on 2020/04/16.
//  Copyright © 2020 JONGWOO JIN. All rights reserved.
//

import SwiftUI

struct UserDetailView: View {
    
    var order: Order
    
    var body: some View {
        List {
        
            Section {
                
                Text("name")
                Text("email")
                Text("phone")
                Text("address")
                
            }//Section
            
        }//List
        .listStyle(GroupedListStyle())
        .navigationBarTitle("User Profile")
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(order: Order())
    }
}
