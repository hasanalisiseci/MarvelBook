//
//  Utils.swift
//  MarvelBook
//
//  Created by Hasan Ali Şişeci on 8.08.2024.
//

import UIKit

class Utils {
    static let shared = Utils()

    public func createLabel(str: String) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        label.text = "\(str)"
        label.font = UIFont(name: label.font.familyName, size: 24)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }

    public func getWindow() -> UIWindow? {
        if #available(iOS 13.0, *) {
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({ $0.activationState == .foregroundActive })
                .map({ $0 as? UIWindowScene })
                .compactMap({ $0 })
                .first?.windows
                .filter({ $0.isKeyWindow }).first
            return keyWindow
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
