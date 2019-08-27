//
//  Message.swift
//  App
//
//  Created by Iyin Raphael on 8/20/19.
//

import Foundation
import Vapor
import FluentSQLite


//MARK: - Fluent - Vapor's remarkably powerful database abstraction layer
struct Message: Content, SQLiteUUIDModel, Migration {
    
    var id: UUID?
    var username: String
    var content: String
    var date: Date
    
}
