//
//  RecordsViewViewModel.swift
//  DepremHasarTespit
//
//  Created by yunus oktay on 11.07.2023.
//

import Foundation
import Firebase

protocol RecordViewViewModelDelegate: AnyObject {
    func dataUpdated()
}

class RecordViewViewModel {
    
    weak var delegate: RecordViewViewModelDelegate?
    var titleArray = [String]()
    var addressArray = [String]()
    var imageDataArray = [Data]()
    
    func getInfo() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        let documentRef = db.collection("users").document(currentUserID).collection("userData")
        
        documentRef.addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.titleArray.removeAll()
                self.addressArray.removeAll()
                self.imageDataArray.removeAll()
                
                for document in snapshot!.documents {
                    let documentId = document.documentID
                    
                    if let title = document.get("title") as? String {
                        self.titleArray.append(title)
                    }
                    
                    if let address = document.get("address") as? String {
                        self.addressArray.append(address)
                    }
                    
                    if let imageURLs = document.get("imageURLs") as? [String] {
                        for imageURLString in imageURLs {
                            if let imageURL = URL(string: imageURLString) {
                                URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                                    if let error = error {
                                        print(error.localizedDescription)
                                        return
                                    }
                                    
                                    if let data = data {
                                        DispatchQueue.main.async {
                                            self.imageDataArray.append(data)
                                            
                                            if let delegate = self.delegate {
                                                delegate.dataUpdated()
                                            }
                                        }
                                    }
                                }.resume()
                            }
                        }
                    }
                }
            }
        }
    }
}


