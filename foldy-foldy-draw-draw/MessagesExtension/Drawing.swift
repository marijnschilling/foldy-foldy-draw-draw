//
//  Drawing.swift
//  foldy-foldy-draw-draw
//
//  Created by Marijn Schilling on 29/06/16.
//  Copyright © 2016 Marijn Schilling. All rights reserved.
//

import Foundation
import Messages

struct Drawing {

    var head: NWADrawing?

    var torso: NWADrawing?

    var legs: NWADrawing?

    var feet: NWADrawing?

    var isComplete: Bool {
        return head != nil && torso != nil && legs != nil && feet != nil
    }
    
    init(){
        
    }

    init?(message: MSMessage?) {
        
    }
}
    
