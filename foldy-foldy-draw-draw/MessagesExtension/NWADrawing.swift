//
//  NWADrawing.swift
//  MyOwnStickerApp
//
//  Created by Bruno Scheele on 29/06/16.
//  Copyright © 2016 Noodlewerk Apps. All rights reserved.
//

import UIKit

/// A representation for a simple drawing.
struct NWADrawing {
    
    init() {
        
    }
    
    /// Returns the number of strokes in the drawing.
    var numberOfStrokes: Int {
        get {
            return strokes.count
        }
    }
    
    /// The array of NSBezierCurves representing the drawing.
    private (set) var strokes: [UIBezierPath] = []
    
    /// Adds a stroke to the drawing.
    mutating func addStroke(stroke: UIBezierPath) {
        strokes.append(stroke)
    }
    
    /// Removes and returns the last drawn stroke in the drawing or returns nil if there are no strokes.
    mutating func removeLastStroke() -> UIBezierPath? {
        if strokes.count > 0 {
            return strokes.removeLast()
        }
        return nil
    }
    
    /// Applies the affine transformation to the drawing.
    mutating func applyTransformation(transformation: CGAffineTransform) {
        for stroke in strokes {
            var transform = transformation
            stroke.cgPath = stroke.cgPath.copy(using: &transform)!
        }
    }
}

// MARK: - JSON stuff

extension NWADrawing {
    
    init(dict: NSDictionary) {
        if let array: [String] = dict.value(forKey: "strokes") as? [String]
        {
            for string in array {
                if let data  = Data(base64Encoded: string), let bezierPath: UIBezierPath = NSKeyedUnarchiver.unarchiveObject(with: data) as? UIBezierPath
                {
                    addStroke(stroke: bezierPath)
                }
            }
        }
    }
    
    func toJSON() -> NSDictionary
    {
        var array = [String]()
        for path in strokes {
            let data = NSKeyedArchiver.archivedData(withRootObject: path)
            let string = data.base64EncodedString()
            array.append(string)
        }
        return ["strokes" : array]
    }
}
