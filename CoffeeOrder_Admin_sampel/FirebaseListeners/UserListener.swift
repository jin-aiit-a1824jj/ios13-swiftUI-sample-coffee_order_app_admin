//
//  UserListener.swift
//  CoffeeOrder_Admin_sampel
//
//  Created by JONGWOO JIN on 2020/04/16.
//  Copyright © 2020 JONGWOO JIN. All rights reserved.
//

import Foundation
import Firebase

func downloadUser(userID: String, completion: @escaping (_ user: FUser?)->Void) {
    FirebaseReference(.User).whereField(kID, isEqualTo: userID).getDocuments { (snapshot, error) in
        
        guard let snapshot = snapshot else { return }
        
        if !snapshot.isEmpty {
            let userData = snapshot.documents.first!.data()
            completion(FUser(userData as NSDictionary))
        }else {
            completion(nil)
        }
        
    }
}
