//
//  SignUpRequest.swift
//  TDlist
//
//  Created by 정수빈 on 2022/02/21.
//

import Foundation

struct SignUpRequest: Encodable {
    var username: String
    var userid: String
    var userpw: String
    var userpw_check: String
}
