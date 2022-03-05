//
//  AddRequest.swift
//  TDlist
//
//  Created by 정수빈 on 2022/02/21.
//

import Foundation

struct AddRequest: Encodable {
    var title: String
    var data: String
    var userid: String
    var content: String
}
