//
//  TODOListModel.swift
//  TODOList
//
//  Created by Vishal Khokad on 22/06/24.
//

import Foundation

struct TODOResponseModel: Codable {
    var id: Int
    var userId: Int
    var title: String
    var completed: Bool
}

struct LocalTODOListModel: Codable {
    var date: Date
    var title: String
    var itemDescription: String
    var isCompleted: Bool
}
