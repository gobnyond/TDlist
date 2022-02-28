//
//  ButtonRadius.swift
//  TDlist
//
//  Created by 정수빈 on 2022/02/12.
//

import UIKit

class ButtonRadius: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0{
           didSet{
           self.layer.cornerRadius = cornerRadius
           }
       }

       @IBInspectable var borderWidth: CGFloat = 0{
           didSet{
               self.layer.borderWidth = borderWidth
           }
       }

       @IBInspectable var borderColor: UIColor = UIColor.clear{
           didSet{
               self.layer.borderColor = borderColor.cgColor
           }
       }

}

