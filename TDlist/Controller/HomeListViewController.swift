//
//  HomeListViewController.swift
//  TDlist
//
//  Created by 정수빈 on 2022/02/24.
//

import UIKit
import Alamofire
import FSCalendar
import SnapKit

class HomeListViewController: UIViewController {

    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarHeight: NSLayoutConstraint!
    @IBOutlet weak var toDoListTable: UITableView!
    
    var todo: [to] = []
    
    func postHome(_ parameters: HomeRequest) {
        AF.request("http://13.209.10.30:4004/todo/list", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: HomeResponse.self) { [self] response in
                switch response.result {
                case .success(let response):
            
                    if response.isSuccess == true {
                        print("불러오기 성공")
                        self.todo = response.todo
                        self.toDoListTable.reloadData()
                        //?
                        let alert = UIAlertController(title: "", message: response.message, preferredStyle: .alert)
                        let okButton = UIAlertAction (title: "확인",style: .default, handler: nil)
                        alert.addAction(okButton)
                        self.present(alert, animated:true)
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
        
        calendar.delegate = self
        calendar.dataSource = self
        
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        calendar.scope = .month
        calendar.scope = .week
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeEvent(_:)))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeEvent(_:)))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
        self.navigationController?.navigationBar.tintColor = .black
        
        toDoListTable.estimatedRowHeight = 50
        toDoListTable.rowHeight = UITableView.automaticDimension
        
    }
}
    
    extension HomeListViewController : FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    public func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        print(dateFormatter.string(from: date) + " 날짜가 선택되었습니다.")
        
        self.toDoListTable.delegate = self
        self.toDoListTable.dataSource = self
        self.toDoListTable.register(UINib(nibName: "HomeTodoTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTodoTableViewCell")
        
        let param = HomeRequest(userid: UserDefaults.standard.object(forKey: "save_id") as! String)
        
        self.postHome(param)
    }
    // 날짜 선택 해제 시 콜백 메소드
    public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        print(dateFormatter.string(from: date) + " 날짜가 선택해제 되었습니다.")    }
    
    public func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool){
        if calendar.scope == .week {
                    calendarHeight.constant = bounds.height
                }
                else if calendar.scope == .month {
                    calendarHeight.constant = bounds.height
                }
        UIView.animate(withDuration: 0.5) {
        self.view.layoutIfNeeded()
        }
    }
}

    
extension HomeListViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    @objc func swipeEvent(_ swipe: UISwipeGestureRecognizer) {

        if swipe.direction == .up {
                calendar.setScope(.week, animated: true)
            } else if swipe.direction == .down {
                calendar.setScope(.month, animated: true)
        }
    }
}
