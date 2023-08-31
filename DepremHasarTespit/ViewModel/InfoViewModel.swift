//
//  InfoViewModel.swift
//  DepremHasarTespit
//
//  Created by yunus oktay on 11.07.2023.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore

class InfoViewModel {
    
    private let db = Firestore.firestore()
    
    private func uploadImagesToStorage(images: [UIImage], currentUserID: String, documentRef: DocumentReference, completion: @escaping (Bool) -> Void) {
        let group = DispatchGroup()
        var imageURLs: [String] = []

        for (index, image) in images.enumerated() {
            guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                continue
            }

            group.enter()
            let imageFileName = UUID().uuidString
            let imageRef = Storage.storage().reference().child("users/\(currentUserID)/\(imageFileName).jpg")

            imageRef.putData(imageData, metadata: nil) { (metadata, error) in
                if let error = error {
                    print("Hata yüklenirken: \(error.localizedDescription)")
                } else {
                    imageRef.downloadURL { (url, error) in
                        if let error = error {
                            print("Hata alındı: \(error.localizedDescription)")
                        } else if let downloadURL = url?.absoluteString {
                            imageURLs.append(downloadURL)
                        }
                        group.leave()
                    }
                }
            }
        }

        group.notify(queue: .main) {
            documentRef.updateData(["imageURLs": imageURLs]) { error in
                if let error = error {
                    print("Hata: \(error.localizedDescription)")
                    completion(false)
                } else {
                    completion(true)
                }
            }
        }


    }
    func saveUserData(title: String, address: String, locality: String, subLocality: String, administrativeArea: String, images: [UIImage], completion: @escaping (Bool) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }

        let documentRef = db.collection("users").document(currentUserID).collection("userData").document()

        documentRef.setData([
            "title": title,
            "address": address,
            "locality": locality,
            "subLocality": subLocality,
            "administrativeArea": administrativeArea
            
        ]) { error in
            if let error = error {
                print("Hata: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Veriler başarıyla Firestore'a kaydedildi.")
                self.uploadImagesToStorage(images: images, currentUserID: currentUserID, documentRef: documentRef, completion: completion)
            }
        }
    }
}



