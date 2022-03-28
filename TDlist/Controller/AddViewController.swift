//
//  AddViewController.swift
//  TDlist
//
//  Created by 정수빈 on 2022/02/24.
//

import UIKit
import Alamofire

class AddViewController: UIViewController {

    
    @IBOutlet weak var addTitleTextfield: UITextField!
    @IBOutlet weak var addDatePicker: UIDatePicker!
    @IBOutlet weak var addMemoTextView: UITextView!
    
    var todoDate: String?
    
    func postAdd(_ parameters: AddRequest) {
        AF.request("http://13.209.10.30:4004/todo", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: AddResponse.self) { [self] response in
                switch response.result {
                case .success(let response):
            
                    if response.isSuccess == true {
                        print("todo 성공")
                        //let storyBoard = UIStoryboard(name: "Home", bundle: nil)
                        //let vc = storyBoard.instantiateViewController(withIdentifier: "HomeListViewController") as! HomeListViewController
                        //vc.modalPresentationStyle = .fullScreen
                        //self.present(vc, animated: true, completion: nil)
                        
                
                       
                    } else {
                        print("todo 실패")
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
    
    @IBAction func addDatePickerAction(_ sender: UIDatePicker) {
        let datepk = sender
        let dateFormet = DateFormatter()
        dateFormet.dateFormat = "yyyy/MM/dd HH:mm[일정]"
        todoDate = dateFormet.string(from:datepk.date)
    }
    
    
    @IBAction func addButton(_ sender: UIButton) {
        let title = addTitleTextfield.text ?? ""
        guard let date = self.todoDate else {
            print ("일정 없음")
            return
        }
        let memo = addMemoTextView.text ?? ""
        
        let param = AddRequest(title: title, date: date, userid: UserDefaults.standard.object(forKey: "save_id") as! String, content: memo)
            postAdd(param)
    }
    
}
