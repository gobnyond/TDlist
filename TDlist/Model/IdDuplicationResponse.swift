//
//  IdDuplicationResponse.swift
//  TDlist
//
//  Created by 정수빈 on 2022/02/21.
//

import Foundation

struct IdDuplicationResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
