//
//  LoadingManager.swift
//  MarvelBook
//
//  Created by Hasan Ali Şişeci on 9.08.2024.
//

import UIKit

class LoadingManager {
    
    private var isLoadingVisible:Bool = false
    private init() {}
    
    static let shared = LoadingManager()
    
    func visible(_ show: Bool = true, bgColor: UIColor = UIColor.black.withAlphaComponent(0.1)) {
        DispatchQueue.main.async {
            if show {
                MainSpinner.spin(bgColor)
            }else {
                MainSpinner.stop()
                //isLoadingVisible = false
            }
        }
    }
}
