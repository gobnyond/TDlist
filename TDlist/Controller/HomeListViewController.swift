//
//  HomeListViewController.swift
//  TDlist
//
//  Created by 정수빈 on 2022/02/24.
//

import UIKit
import Alamofire

class HomeListViewController: UIViewController {

    @IBOutlet weak var toDoListTable: UITableView!
    
    var todo: [todo] = []
    
    func postHome(_ parameters: HomeRequest) {
        AF.request("http://13.209.10.30:4004/todo/list", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: HomeResponse.self) { [self] response in
                switch response.result {
                case .success(let response):
            
                    if response.isSuccess == true {
                        print("불러오기 성공")
                        self.todo = response.list
                        self.toDoListTable.reloadData()
                        //?
                    } else {
                        print("불러오기 실패")
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
        self.navigationController?.navigationBar.topItem?.title = ""
        
        toDoListTable.estimatedRowHeight = 50
        toDoListTable.rowHeight = UITableView.automaticDimension
        
        self.toDoListTable.delegate = self
        self.toDoListTable.dataSource = self
        self.toDoListTable.register(UINib(nibName: "HomeTodoTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTodoTableViewCell")
        
        let param = HomeRequest(userid: UserDefaults.standard.object(forKey: "save_id") as! String)
        self.postHome(param)
    }

}

extension HomeListViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todo.count
}
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeListTableViewCell", for: indexPath) as! HomeListTableViewCell
        let data = self.todo[indexPath.row]
        cell.titleLabel.text = data.title
        cell.dateLabel.text = "\(data.date)"
        cell.contentLabel.text = data.content

        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as!
        DetailViewController
        
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.pushViewController(vc, animated: true)
        
        vc.detailtitle = todo[indexPath.row].title
        vc.detaildate = todo[indexPath.row].date
        vc.detailcontent = todo[indexPath.row].content
        
        }
    
        
}
