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
    
    @objc func textFieldDidChange(_ sender: Any?) {
        signNameTextfield.clearsOnBeginEditing = false
    }
    
    func postIdDuplicate(_ parameters: IdDuplicationRequest) {
        AF.request("http://13.209.10.30:4004/user/duplicate", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: SignUpResponse.self) { [self] response in
                switch response.result {
                case .success(let response):
            
                    if response.isSuccess == true {
                        print("사용 가능한 아이디")
                        self.idLabel?.text = response.message
                       
                    } else {
                        print("아이디 확인 실패")
                        self.idLabel?.text = response.message
                  }
                case .failure(let error):
                    print("failure \(error.localizedDescription)")
              }
         }
    }
    
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
        
       // signNameTextfield.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        self.signNameTextfield.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
        let name = signNameTextfield.text ?? ""
        signNameTextfield.delegate = self
        let parameter = IdDuplicationRequest(userid: name)
            postIdDuplicate(parameter)

    }
    
    @IBAction func signupActionButton(_ sender: UIButton) {
        let name = signNameTextfield.text ?? ""
        let id = signIdTextfield.text ?? ""
        let pw = signPwTextfield.text ?? ""
        let pw_check = signPwcheckTextfield.text ?? ""
        
        //let parameter = IdDuplicationRequest(userid: name)
            //postIdDuplicate(parameter)
        
        let param = SignUpRequest(username: name, userid: id, userpw: pw, userpw_check: pw_check)
            postSignUp(param)
    }
    
  
}
                                    
// func textFieldDidChange (textField: UITextField) {
// }
