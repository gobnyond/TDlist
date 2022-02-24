//
//  SignUpViewController.swift
//  TDlist
//
//  Created by 정수빈 on 2022/02/21.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var signNameTextfield: UITextField!
    @IBOutlet weak var signIdTextfield: UITextField!
    @IBOutlet weak var signPwTextfield: UITextField!
    @IBOutlet weak var signPwcheckTextfield: UITextField!
    @IBOutlet weak var idLabel: UILabel!
    
    func postSignUp(_ parameters: SignUpRequest) {
        AF.request("http://13.209.10.30:4004/user", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: SignUpResponse.self) { [self] response in
                switch response.result {
                case .success(let response):
            
                    if response.isSuccess == true {
                        print("회원가입 성공")
                        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as!
                        LoginViewController
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                       
                    } else {
                        print("회원가입 실패")
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
    
    
    @IBAction func signupActionButton(_ sender: UIButton) {
        let name = signNameTextfield.text ?? ""
        let id = signIdTextfield.text ?? ""
        let pw = signPwTextfield.text ?? ""
        let pw_check = signPwcheckTextfield.text ?? ""
        
        let param = SignUpRequest(username: name, userid: id, userpw: pw, userpw_check: pw_check)
            postSignUp(param)
    }
    
  
}
