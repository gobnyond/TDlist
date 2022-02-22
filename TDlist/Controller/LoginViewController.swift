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
            .responseDecodable(of: LoginResponse.self) { [self] response in
                switch response.result {
                case .success(let response):
            
                    if response.isSuccess == true {
                        print("로그인 성공")
                       
                    } else {
                        print("로그인 실패")
                        let alert = UIAlertController(title: "", message: response.message, preferredStyle: .alert)
                        let okButton = UIAlertAction (title: "확인",style: .default, handler: nil)
                        alert.addAction(okButton)
                        self.present(alert, animated:true)
                  }
                case .failure(let error):
                    print("failure \(error.localizedDescription)")
              }
         }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginActionButton(_ sender: UIButton) {
        let id = userIdTextfield.text ?? ""
        let pw = userPwTextfield.text ?? ""
        
        let param = LoginRequest(userid: id, userpw: pw)
            postLogin(param)
    }
    
    @IBAction func signupActionButton(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as!
        SignUpViewController
        self.present(vc, animated: true, completion: nil)
    }
    
}
