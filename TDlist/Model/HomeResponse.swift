//
//  HomeResponse.swift
//  TDlist
//
//  Created by 정수빈 on 2022/02/21.
//

import Foundation

struct HomeResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var todo: [to]
}

struct to: Decodable {
    var no: Int?
    var title: String
    var content: String
    var userid: String?
    var date: Int
}
