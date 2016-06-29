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
}

extension Drawing {
    init?(message: MSMessage?) {

    }
}

// MARK: - JSON stuff

extension Drawing {
    
    init?(json: String)
    {
        self.head = nil
        self.torso = nil
        self.legs = nil
        self.feet = nil
        
        if let jsonData = json.data(using: String.Encoding.utf8)
        {
            do
            {
                let dict = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments)
                
                if let headDict = dict.value(forKey: "head") as? NSDictionary
                {
                    self.head = NWADrawing(dict: headDict)
                }
                
                if let torsoDict = dict.value(forKey: "torso") as? NSDictionary
                {
                    self.torso = NWADrawing(dict: torsoDict)
                }
                
                if let legsDict = dict.value(forKey: "legs") as? NSDictionary
                {
                    self.legs = NWADrawing(dict: legsDict)
                }
                
                if let feetDict = dict.value(forKey: "feet") as? NSDictionary
                {
                    self.feet = NWADrawing(dict: feetDict)
                }
                
            } catch let error {
                print(error)
            }
            
        } else {
            
        }
    }
    
    func toJSONData() -> Data?
    {
        let dict = NSDictionary()
        if self.head != nil
        {
            dict.setValue(self.head?.toJSON(), forKey: "head")
        }
        
        if self.torso != nil
        {
            dict.setValue(self.torso?.toJSON(), forKey: "torso")
        }
        
        if self.legs != nil
        {
            dict.setValue(self.legs?.toJSON(), forKey: "legs")
        }
        
        if self.feet != nil
        {
            dict.setValue(self.feet?.toJSON(), forKey: "feet")
        }
        var data: Data? = nil
        do {
            data = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch {
            // oops
        }
        return data
    }
}

    
