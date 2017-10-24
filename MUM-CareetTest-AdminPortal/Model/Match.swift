//
//  Match.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/24/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import Foundation

struct Match{
    var text: String
    var parcentage: Double
    
    init(question: String, parc: Double) {
        text = question
        parcentage = parc
    }
    
}

extension Match: Equatable, Comparable {
    static func <(lhs: Match, rhs: Match) -> Bool {
        if (lhs.parcentage < rhs.parcentage) {
            return true
        }else{
            return false
        }
    }
    
    static func == (lhs: Match, rhs: Match) -> Bool {
        if (lhs.parcentage == rhs.parcentage){
            return true
        }else{
            return false
        }
    }
}

