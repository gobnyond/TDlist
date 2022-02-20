//
//  Home.swift
//  TDlist
//
//  Created by 정수빈 on 2022/02/21.
//

import Foundation

struct AladinOpen: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var list: [todo]
}

struct todo: Decodable {
    var title: String
    var date: Int
    var content: String
}
