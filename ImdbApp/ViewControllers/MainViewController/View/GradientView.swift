//
//  GradientView.swift
//  ImdbApp
//
//  Created by Tom on 06/02/2022.
//

import UIKit

class GradientView: UIView {
    var startColor: UIColor!
    var endColor: UIColor!
    var startPoint: CGPoint!
    var endPoint: CGPoint!
    var gradientCenter: CGPoint!
    var radius: CGFloat!
    var gradientLocation: [CGFloat]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        drawCircleGradient(in: rect, andColors: (startColor, endColor),
                           andCenter: gradientCenter, andRadius: radius,
                           location: gradientLocation)
    }
    
    private func drawCircleGradient(in rect: CGRect, andColors colors: (UIColor, UIColor),
                                    andCenter center: CGPoint, andRadius radius: CGFloat,
                                    location: [CGFloat]? = [0.0, 0.1]) {
        let context = UIGraphicsGetCurrentContext()!
        let colors = [colors.0.cgColor, colors.1.cgColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: location)!
        
        context.drawRadialGradient(gradient,
                                   startCenter: center,
                                   startRadius: 0,
                                   endCenter: center,
                                   endRadius: radius,
                                   options: [.drawsAfterEndLocation, .drawsBeforeStartLocation])
    }
}
