//
//  AnimatedCheckmarkView.swift
//  HeadFlow
//
//  Created by Daria Andrioaie on 25.02.2023.
//

import Foundation
import SwiftUI

struct AnimatedCheckmarkView: View {
    var animationDuration: Double = 1
    var shouldScale = true
    var size: CGSize = .init(width: 150, height: 150)
    var innerShapeSizeRatio: CGFloat = 1/3
    var fromColor: Color = .oceanBlue
    var toColor: Color = .feathers
    var strokeStyle: StrokeStyle = .init(lineWidth: 10, lineCap: .round, lineJoin: .round)
    var animateOnTap = true
    var outerShape: AnyShape = .init(Circle())
    var onAnimationFinish: (() -> Void)?
    
    @State private var outerTrimEnd: CGFloat = 0
    @State private var innerTrimEnd: CGFloat = 0
    @State private var strokeColor = Color.green
    @State private var scale = 1.0
    
    var body: some View {
        ZStack {
            outerShape
                .trim(from: 0.0, to: outerTrimEnd)
                .stroke(strokeColor, style: strokeStyle)
                .rotationEffect(.degrees(-90))
            
            Checkmark()
                .trim(from: 0, to: innerTrimEnd)
                .stroke(strokeColor, style: strokeStyle)
                .frame(width: size.width * innerShapeSizeRatio,
                       height: size.height * innerShapeSizeRatio)
        }
        .frame(width: size.width, height: size.height)
        .scaleEffect(scale)
        .onAppear() {
            strokeColor = fromColor
            animate()
        }
        .onTapGesture {
            if animateOnTap {
                outerTrimEnd = 0
                innerTrimEnd = 0
                strokeColor = fromColor
                scale = 1
                animate()
            }
        }
    }
    
    
    func animate() {
        if shouldScale {
            withAnimation(.linear(duration: 0.4 * animationDuration)) {
                outerTrimEnd = 1.0
            }
            
            withAnimation(
                .linear(duration: 0.3 * animationDuration)
                .delay(0.4 * animationDuration)
            ) {
                innerTrimEnd = 1.0
            }
            
            withAnimation(
                .linear(duration: 0.2 * animationDuration)
                .delay(0.7 * animationDuration)
            ) {
                strokeColor = toColor
                scale = 1.1
            }
            
            withAnimation(
                .linear(duration: 0.1 * animationDuration)
                .delay(0.9 * animationDuration)
            ) {
                scale = 1
            }
        } else {
            withAnimation(.linear(duration: 0.5 * animationDuration)) {
                outerTrimEnd = 1.0
            }
            withAnimation(
                .linear(duration: 0.3 * animationDuration)
                .delay(0.5 * animationDuration)
            ) {
                innerTrimEnd = 1.0
            }
            
            withAnimation(
                .linear(duration: 0.2 * animationDuration)
                .delay(0.8 * animationDuration)
            ) {
                strokeColor = toColor
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            onAnimationFinish?()
        }
    }
}


struct Checkmark: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.size.width
        let height = rect.size.height
        
        var path = Path()
        path.move(to: .init(x: 0 * width, y: 0.5 * height))
        path.addLine(to: .init(x: 0.4 * width, y: 1.0 * height))
        path.addLine(to: .init(x: 1.0 * width, y: 0 * height))
        return path
    }
}


struct AnyShape: Shape {
    private var path: (CGRect) -> Path
    
    init<S>(_ shape: S) where S: Shape {
        path = shape.path(in:)
    }
    
    func path(in rect: CGRect) -> Path {
        return path(rect)
    }
}

#if DEBUG
struct AnimatedCheckmarkView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(previewDevices) {
            AnimatedCheckmarkView()
            .previewDevice($0)
            .previewDisplayName($0.rawValue)
        }
    }
}
#endif
