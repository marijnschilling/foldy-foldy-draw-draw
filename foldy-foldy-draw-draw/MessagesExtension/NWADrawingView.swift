//
//  NWADrawingView.swift
//  MyOwnStickerApp
//
//  Created by Bruno Scheele on 29/06/16.
//  Copyright © 2016 Noodlewerk Apps. All rights reserved.
//

import UIKit

protocol NWADrawingDelegate {
    func didStartDrawing()
    func clearedDrawing()
}

class NWADrawingView: UIView, NSCopying {
    var delegate: NWADrawingDelegate?
    var drawing: NWADrawing = NWADrawing()
    
    private var currentPath: UIBezierPath? = nil
    private var didNotify: Bool = false
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isMultipleTouchEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isMultipleTouchEnabled = false
    }
    
    // MARK: Public methods
    
    func undoLastStroke() -> Bool {
        if let _ = drawing.removeLastStroke() {
            return true
        }
        else {
            return false
        }
    }
    
    func clearAllStrokes() {
        drawing = NWADrawing()
        didNotify = false
        setNeedsDisplay()
        delegate?.clearedDrawing()
    }
    
    // MARK: Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !didNotify {
            didNotify = true
            delegate?.didStartDrawing()
        }
        
        currentPath = UIBezierPath()
        currentPath?.lineWidth = 10.0
        currentPath?.lineCapStyle = .round
        currentPath?.lineJoinStyle = .round
        if let touch = touches.first {
            currentPath?.move(to: touch.location(in: self))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            currentPath?.addLine(to: touch.location(in: self))
            setNeedsDisplay()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            currentPath?.addLine(to: touch.location(in: self))
            if let path = currentPath {
                drawing.addStroke(stroke: path)
                currentPath = nil
                setNeedsDisplay()
            }
        }
    }
    
    // MARK: Display
    
    override var frame: CGRect {
        get { return super.frame }
        set {
            super.frame = frame
            if self.frame != frame {
                let ratio = frame.size.width / self.frame.size.width
                let transformation = CGAffineTransform(scaleX: ratio, y: ratio)
                drawing.applyTransformation(transformation: transformation)
            }
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        currentPath?.stroke()
        for stroke in drawing.strokes {
            stroke.stroke()
        }
    }
    
    // MARK: NSCopying
    
    func copy(with zone: NSZone? = nil) -> AnyObject {
        let copied = NWADrawingView(frame: frame)
        copied.drawing = drawing
        return copied
    }
    
}
