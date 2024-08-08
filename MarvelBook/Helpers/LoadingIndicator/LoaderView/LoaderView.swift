//
//  LoaderView.swift
//  ToptanPiyasa
//
//  Created by Caner Kaya on 6.12.2022.
//

import UIKit

class LoaderView: UIView {
	@IBOutlet weak var backgroundView: UIView!
	
	var isShowLoader: Bool = false

	override func awakeFromNib() {
		super.awakeFromNib()
		animate()
	}

	private func animate() {
		let width = backgroundView.frame.size.width
		let height = backgroundView.frame.size.height

		let beginTime: Double = 0.5
		let durationStart: Double = 1.2
		let durationStop: Double = 0.7

		let animationRotation = CABasicAnimation(keyPath: "transform.rotation")
		animationRotation.byValue = 2 * Float.pi
		animationRotation.timingFunction = CAMediaTimingFunction(name: .linear)

		let animationStart = CABasicAnimation(keyPath: "strokeStart")
		animationStart.duration = durationStart
		animationStart.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0, 0.2, 1)
		animationStart.fromValue = 0
		animationStart.toValue = 1
		animationStart.beginTime = beginTime

		let animationStop = CABasicAnimation(keyPath: "strokeEnd")
		animationStop.duration = durationStop
		animationStop.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0, 0.2, 1)
		animationStop.fromValue = 0
		animationStop.toValue = 1

		let animation = CAAnimationGroup()
		animation.animations = [animationRotation, animationStop, animationStart]
		animation.duration = durationStart + beginTime
		animation.repeatCount = .infinity
		animation.isRemovedOnCompletion = false
		animation.fillMode = .forwards

		let path = UIBezierPath(arcCenter: CGPoint(x: width/2, y: height/2), radius: width/2, startAngle: -0.5 * .pi, endAngle: 1.5 * .pi, clockwise: true)

		let layer = CAShapeLayer()
		layer.frame = CGRect(x: 0, y: 0, width: width, height: height)
		layer.path = path.cgPath
		layer.fillColor = nil
        layer.strokeColor = UIColor.gray.withAlphaComponent(0.5).cgColor
		layer.lineWidth = 5

		layer.add(animation, forKey: "animation")
		backgroundView.layer.addSublayer(layer)
	}

	public func show(viewController: UIViewController? = nil) {
		if !isShowLoader {
			self.translatesAutoresizingMaskIntoConstraints = false
			if let viewController = viewController {
				viewController.view.addSubview(self)
				self.backgroundView.backgroundColor = .clear
				self.isShowLoader = true
			} else if var topController = UIApplication.shared.delegate?.window??.rootViewController {
				while let presentedViewController = topController.presentedViewController {
					topController = presentedViewController
				}

				topController.view.addSubview(self)
				self.backgroundView.backgroundColor = .clear
				self.isShowLoader = true
			}
		}
	}

	public func hide() {
		if isShowLoader {
			self.isShowLoader = false
			self.removeFromSuperview()
		}
	}

}
