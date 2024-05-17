//
//  GradientView.swift
//  WeatherApp
//
//  Created by Ovais Khan on 5/10/24.
//

import Foundation
import UIKit





class GradientView: UIView {
    @IBInspectable var color1: UIColor = UIColor.red {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable var color2: UIColor = UIColor.blue {
        didSet {
            setNeedsDisplay()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = UIColor.clear
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else { return }

        let colors = [color1.cgColor, color2.cgColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: colorLocations)!

        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: rect.width, y: rect.height)

        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
    }
}
