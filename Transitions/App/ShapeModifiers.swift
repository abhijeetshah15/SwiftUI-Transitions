//
//  ShapeModifiers.swift
//  Transitions
//
//  Created by Abhijeet Shah on 2/17/22.
//

import SwiftUI

//MARK: SHAPECLIPMODIFIER
struct ShapeClipModifier<S: Shape>: ViewModifier {
    
    let shape: S
    
    func body(content: Content) -> some View {
        content.clipShape(shape)
    }
}

//MARK: STRIPESSHAPE
struct StripesShape: Shape {
    let insertion: Bool
    var pct: CGFloat
    let stripes: Int
    let horizontal: Bool
    
    var animatableData: CGFloat {
        get { pct }
        set { pct = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        if horizontal {
            let stripeHeight = rect.height / CGFloat(stripes)
            
            for i in 0..<(stripes) {
                let j = CGFloat(i)
                
                if insertion {
                    path.addRect(CGRect(x: 0, y: j * stripeHeight, width: rect.width, height: stripeHeight * (1-pct)))
                } else {
                    path.addRect(CGRect(x: 0, y: j * stripeHeight + (stripeHeight * pct), width: rect.width, height: stripeHeight * (1-pct)))
                }
            }
        } else {
            let stripeWidth = rect.width / CGFloat(stripes)
            
            for i in 0..<(stripes) {
                let j = CGFloat(i)
                
                if insertion {
                    path.addRect(CGRect(x: j * stripeWidth, y: 0, width: stripeWidth * (1-pct), height: rect.height))
                } else {
                    path.addRect(CGRect(x: j * stripeWidth + (stripeWidth * pct), y: 0, width: stripeWidth * (1-pct), height: rect.height))
                }
            }
        }
        
        return path
    }
}

//MARK: RECTANGULARSHAPE
struct RectangularShape: Shape {
    var pct: CGFloat
    
    var animatableData: CGFloat {
        get { pct }
        set { pct = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addRect(rect.insetBy(dx: pct * rect.width, dy: pct * rect.height))
        
        return path
    }
}

//MARK: CIRCLECLIPSHAPE
struct CircleClipShape: Shape {
    var pct: CGFloat
    
    var animatableData: CGFloat {
        get { pct }
        set { pct = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        var bigRect = rect
        bigRect.size.width = bigRect.size.width * 2 * (1-pct)
        bigRect.size.height = bigRect.size.height * 2 * (1-pct)
        bigRect = bigRect.offsetBy(dx: -rect.width/2.0, dy:-rect.height/2.0)
        
        path = Circle().path(in: bigRect)
        
        return path
    }
}

//MARK: SCALEDCIRCLE
struct ScaledCircle: Shape {
    // This controls the size of the circle inside the
    // drawing rectangle. When it's 0 the circle is
    // invisible, and when it’s 1 the circle fills
    // the rectangle.
    var animatableData: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let maximumCircleRadius = sqrt(rect.width * rect.width + rect.height * rect.height)
        let circleRadius = maximumCircleRadius * animatableData
        
        let x = rect.midX - circleRadius / 2
        let y = rect.midY - circleRadius / 2
        
        let circleRect = CGRect(x: x, y: y, width: circleRadius, height: circleRadius)
        
        return Circle().path(in: circleRect)
    }
}

//MARK: CLIPSHAPEMODIFIER
struct ClipShapeModifier<T: Shape>: ViewModifier {
    let shape: T
    
    func body(content: Content) -> some View {
        content.clipShape(shape)
    }
}

//MARK: CORNERROTATEMODIFIER
struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

//MARK: FLYTRANSITION
struct FlyTransition: GeometryEffect {
    var pct: Double
    
    var animatableData: Double {
        get { pct }
        set { pct = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        
        let rotationPercent = pct
        let a = CGFloat(Angle(degrees: 90 * (1-rotationPercent)).radians)
        
        var transform3d = CATransform3DIdentity;
        transform3d.m34 = -1/max(size.width, size.height)
        
        transform3d = CATransform3DRotate(transform3d, a, 1, 0, 0)
        transform3d = CATransform3DTranslate(transform3d, -size.width/2.0, -size.height/2.0, 0)
        
        let affineTransform1 = ProjectionTransform(CGAffineTransform(translationX: size.width/2.0, y: size.height / 2.0))
        let affineTransform2 = ProjectionTransform(CGAffineTransform(scaleX: CGFloat(pct * 2), y: CGFloat(pct * 2)))
        
        if pct <= 0.5 {
            return ProjectionTransform(transform3d).concatenating(affineTransform2).concatenating(affineTransform1)
        } else {
            return ProjectionTransform(transform3d).concatenating(affineTransform1)
        }
    }
}

//MARK: CLIPEFFECT
struct ClipEffect: ViewModifier {
    var value: CGFloat
    
    func body(content: Content) -> some View {
        content
            .clipShape(RoundedRectangle(cornerRadius: 100*(1-value)).scale(value))
    }
}

//MARK: SLIDINGDOOREFFECT
struct SlidingDoorEffect: ViewModifier {
    let shift: CGFloat
    
    func body(content: Content) -> some View {
        let c = content
        return ZStack {
            c.clipShape(HalfClipShape(left: false)).offset(x: -shift, y: 0)
            c.clipShape(HalfClipShape(left: true)).offset(x: shift, y: 0)
        }
    }
}

//MARK: HALFCLIPSHAPE
struct HalfClipShape: Shape {
    var left: Bool
        
    func path(in rect: CGRect) -> Path {
        // shape covers lef or right part of rect
        return Path { path in
            let width = rect.width
            let height = rect.height
            
            let startx:CGFloat = left ? 0 : width/2
            let shapeWidth:CGFloat = width/2
            
            path.move(to: CGPoint(x: startx, y: 0))
            
            path.addLines([
                CGPoint(x: startx+shapeWidth, y: 0),
                CGPoint(x: startx+shapeWidth, y: height),
                CGPoint(x: startx, y: height),
                CGPoint(x: startx, y: 0)
            ])
        }
    }
}
