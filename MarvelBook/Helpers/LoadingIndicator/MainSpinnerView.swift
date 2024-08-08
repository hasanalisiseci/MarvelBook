//
//  MainSpinnerView.swift
//  MarvelBook
//
//  Created by Hasan Ali Şişeci on 9.08.2024.
//

import UIKit

open class MainSpinner {
    internal static var progressContainerView: UIView?
    
    public static var backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.1)
    
    internal static var touchHandler: (() -> Void)?
    
    public static func spin(_ backgroundColor: UIColor = backgroundColor, touchHandler: (() -> Void)? = nil) {
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            if let pView = progressContainerView {
                window.addSubview(pView)
            } else {
                let progressBackgroundView = UIView(frame: UIScreen.main.bounds)
                progressBackgroundView.backgroundColor = backgroundColor
                
                let loaderView: LoaderView = LoaderView.fromNib()
                loaderView.backgroundColor = UIColor.clear
                loaderView.backgroundView.backgroundColor = UIColor.clear
                loaderView.center = progressBackgroundView.center
                
                progressBackgroundView.addSubview(loaderView)
                window.addSubview(progressBackgroundView)
                window.bringSubviewToFront(progressBackgroundView)

                self.progressContainerView = progressBackgroundView
            }
        }
        
        if touchHandler != nil {
            self.touchHandler = touchHandler
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(runTouchHandler))
            progressContainerView!.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @objc internal static func runTouchHandler() {
        if touchHandler != nil {
            touchHandler!()
        }
    }
    
    public static func stop() {
        if let view = progressContainerView {
            view.removeFromSuperview()
            progressContainerView = nil
        }
    }
}

