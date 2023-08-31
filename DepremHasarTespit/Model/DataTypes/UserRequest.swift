//
//  UserRequest.swift
//  DepremHasarTespit
//
//  Created by yunus oktay on 20.06.2023.
//

import Foundation

struct User {
    let uuid: String
    let email: String?
    let imageURLs: [String]
    let address: [String]
    let title: [String]
    let locality: [String]
    let subLocality: [String]
    let administrativeArea: [String]
}
