//
//  DetailViewController.swift
//  TDlist
//
//  Created by 정수빈 on 2022/02/24.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailtitleLabel: UILabel!
    @IBOutlet weak var detaildateLabel: UILabel!
    @IBOutlet weak var detailcontentLabel: UILabel!
    
    var detailtitle:String?
    var detaildate:Int?
    var detailcontent:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailtitleLabel.text = detailtitle
        detaildateLabel.text = "\(detaildate ?? 0)"
        detailcontentLabel.text = detailcontent
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
