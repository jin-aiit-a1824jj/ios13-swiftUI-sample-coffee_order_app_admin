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
    @State var user:FUser?
    var body: some View {
        List {
            
            Section {
                
                Text(user?.fullName ?? "")
                Text(user?.email ?? "")
                Text(user?.phoneNumber ?? "")
                Text(user?.fullAddress ?? "")
                
            }//Section
            
        }//List
            .listStyle(GroupedListStyle())
            .navigationBarTitle("User Profile")
            .onAppear(perform: {
                self.getUser()
            })
    }
    
    private func getUser() {
        downloadUser(userID: order.customerId) { (fuser) in
            self.user = fuser
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(order: Order())
    }
}
