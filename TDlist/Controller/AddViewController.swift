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
                        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
                        let vc = storyBoard.instantiateViewController(withIdentifier: "HomeListViewController") as!
                        HomeListViewController
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                
                       
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
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    @IBAction func addDatePickerAction(_ sender: UIDatePicker) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        todoDate = formatter.string(from: sender.date)
    }
    
    
    @IBAction func addButton(_ sender: UIButton) {
        let title = addTitleTextfield.text ?? ""
        guard let date = todoDate else { return }
        let memo = addMemoTextView.text ?? ""
        
        let param = AddRequest(title: title, data: date, userid: UserDefaults.standard.object(forKey: "save_id") as! String, content: memo )
            postAdd(param)
    }
    
}
