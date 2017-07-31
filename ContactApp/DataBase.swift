//
//  DataBase.swift
//  ContactApp
//
//  Created by kaleb riley on 7/31/17.
//  Copyright © 2017 kaleb riley. All rights reserved.
//

import Foundation
import SQLite

class DataBase {
    static let instance = DataBase()
    private let db: Connection?
    
    private let contacts = Table("contacts")
    private let id = Expression<Int64>("id")
    private let firstName = Expression<String?>("firstName")
    private let lastName = Expression<String?>("lastName")
    private let dob = Expression<String?>("dateOfBirth")
    private let phoneNumber = Expression<String>("phoneNumber")
    private let zip = Expression<String>("zip")
    
    private init() {
        guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            print("Could not access Database path")
            db = nil
            return
        }
        
        do {
            db = try Connection("\(path)/Stephencelis.sqlite3")
        } catch {
            db = nil
            print ("Unable to open database")
        }
        
        createTable()
    }
    
    func createTable() {
        do {
            try db!.run(contacts.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(firstName)
                table.column(lastName)
                table.column(dob)
                table.column(phoneNumber, unique: true)
                table.column(zip)
            })
        } catch {
            print("Unable to create table")
        }
    }
}
