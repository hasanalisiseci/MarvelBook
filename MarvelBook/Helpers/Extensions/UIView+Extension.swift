//
//  UIView+Extension.swift
//  MarvelBook
//
//  Created by Hasan Ali Şişeci on 9.08.2024.
//

import UIKit

extension UIView {
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
