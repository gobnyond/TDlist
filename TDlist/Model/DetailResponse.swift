//
//  DetailResponse.swift
//  TDlist
//
//  Created by 정수빈 on 2022/02/21.
//

import Foundation

struct DetailResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var detailList: [detailTodo]
}

struct detailTodo: Decodable {
    var detailtitle: String
    var detaildate: Int
    var detailcontent: String
}
