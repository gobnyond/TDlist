//
//  LoginViewController.swift
//  TDlist
//
//  Created by 정수빈 on 2022/02/21.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var userIdTextfield: UITextField!
    @IBOutlet weak var userPwTextfield: UITextField!
    
    func postLogin(_ parameters: LoginRequest) {
        AF.request("13.209.10.30:4004/user/login", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: LoginResponse.self) { [_] response in
                switch response.result {
                case .success(let response):
            
                    if response.isSuccess == true {
                        print("로그인 성공")
                       
                    } else {
                        print("로그인 실패")
                    
                    }
                case .failure(let error):
                    print("error")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginActionButton(_ sender: UIButton) {
    }
    @IBAction func signupActionButton(_ sender: UIButton) {
    }
    

}
