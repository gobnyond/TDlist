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
    @IBOutlet weak var autoLogin: UISwitch!
    
    func postLogin(_ parameters: LoginRequest) {
        AF.request("http://13.209.10.30:4004/user/login", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: LoginResponse.self) { [self] response in
                switch response.result {
                case .success(let response):
            
                    if response.isSuccess == true {
                        print("로그인 성공")
                        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
                        let vc = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as!
                        HomeViewController
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                       
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
        autoLogin.transform = CGAffineTransform(scaleX: 0.55, y: 0.55); //스위치 크기
        
        if let save_id:String = UserDefaults.standard.object(forKey: "save_id") as? String,
           let save_pw:String = UserDefaults.standard.object(forKey: "save_pw") as? String {
    
        let param = LoginRequest(userid: save_id, userpw: save_pw)
            postLogin(param)
        }
        
    }

    @IBAction func loginActionButton(_ sender: UIButton) {
        
        //autoLogin.transform = CGAffineTransform(scaleX: 0.5, y: 0.5); //스위치 크기
        let id = userIdTextfield.text ?? ""
        let pw = userPwTextfield.text ?? ""
        
        if autoLogin.isOn{ //스위치가 켜져있을때
                    let dataSave = UserDefaults.standard // UserDefaults.standard 정의
                    dataSave.setValue(id, forKey: "save_id") // save_userNm 키값에 id값 저장
                    dataSave.setValue(pw, forKey: "save_pw") // save_pw 키값에 pw값 저장
                     
                    UserDefaults.standard.synchronize() // setValue 실행
                } else { // 스위치가 꺼져있을때
                    let dataSave = UserDefaults.standard
                    dataSave.setValue("nil", forKey: "save_id")
                    dataSave.setValue("nil", forKey: "save_pw")
                     
                    UserDefaults.standard.synchronize()
                }
                 
                print("\(UserDefaults.standard.value(forKey: "save_id")!)")
                print("\(UserDefaults.standard.value(forKey: "save_pw")!)")
        
        let param = LoginRequest(userid: id, userpw: pw)
            postLogin(param)
        
    }
    
    @IBAction func signupActionButton(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as!
        SignUpViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}
