//
//  Message.swift
//  App
//
//  Created by Iyin Raphael on 8/20/19.
//

import Foundation
import Vapor

struct Message: Content {
    
    var id: UUID?
    var username: String
    var content: String
    var date: Date
    
}
