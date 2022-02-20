//
//  AddResponse.swift
//  TDlist
//
//  Created by 정수빈 on 2022/02/21.
//

import Foundation

struct AddResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
