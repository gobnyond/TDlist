//
//  SignUpRequest.swift
//  TDlist
//
//  Created by 정수빈 on 2022/02/21.
//

import Foundation

struct SignUpRequest: Encodable {
    var id: String
    var pw: String
    var username: String
}
