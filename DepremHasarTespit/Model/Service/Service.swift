//
//  Service.swift
//  DepremHasarTespit
//
//  Created by yunus oktay on 20.06.2023.
//

import Foundation
import Firebase
import FirebaseFirestore

class Service {
    
    static let shared = Service()
    private let db = Firestore.firestore()
    
    private init() {}
    
    func fetchUserInfo(completion: @escaping (User?) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            completion(nil)
            return
        }
        
        let documentRef = db.collection("users").document(currentUserID)
        
        documentRef.getDocument { (snapshot, error) in
            if let error = error {
                print("Hata alındı: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let snapshot = snapshot, snapshot.exists, let data = snapshot.data() {
                let email = data["email"] as? String
                let uuid = data["uuid"] as? String
                let imageURLs = data["imageURLs"] as? [String] ?? []
                let address = data["address"] as? [String] ?? []
                let title = data["title"] as? [String] ?? []
                let locality = data["locality"] as? [String] ?? []
                let subLocality = data["subLocality"] as? [String] ?? []
                let administrativeArea = data["administrativeArea"] as? [String] ?? []
                
                let user = User(uuid: uuid!, email: email, imageURLs: imageURLs, address: address, title: title, locality: locality, subLocality: subLocality, administrativeArea: administrativeArea)
                
                completion(user)
            } else {
                completion(nil)
            }
        }
    }
}


