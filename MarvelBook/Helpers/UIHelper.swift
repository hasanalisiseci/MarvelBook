//
//  UIHelper.swift
//  MarvelBook
//
//  Created by Hasan Ali Şişeci on 8.08.2024.
//

import UIKit

enum UI {
    enum Size {
        enum Screen {
            static let width: CGFloat = UIScreen.main.bounds.width
            static let height: CGFloat = UIScreen.main.bounds.height
        }

        enum StatusBar {
            static var height: CGFloat { SafeArea.insets.top }
        }

        enum SafeArea {
            static var insets: UIEdgeInsets {
                let keyWindow = UIApplication.shared.connectedScenes
                    .filter { $0.activationState == .foregroundActive }
                    .map { $0 as? UIWindowScene }
                    .compactMap { $0 }
                    .first?.windows
                    .filter { $0.isKeyWindow }.first
                return (keyWindow?.safeAreaInsets)!
            }
        }

        enum NavigationBar {
            static let height: CGFloat = 64
        }

        enum Home {
            static let bannerHeight: CGFloat = 138
            static let bannerHeightForGuest: CGFloat = 92
        }

        enum Button {
            static let defaultWidth: CGFloat = 214
            static let defaultHeight: CGFloat = 48
        }

        enum Alert {
            static let width: CGFloat = Screen.width - 48
        }
    }
}
