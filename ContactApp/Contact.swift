//
//  Contact.swift
//  ContactApp
//
//  Created by kaleb riley on 7/31/17.
//  Copyright © 2017 kaleb riley. All rights reserved.
//

import Foundation

class Contact {
    let id: Int64?
    var firstName: String
    var lastName: String
    let dateOfBirth: Date
    let phoneNumber: String
    let zipCode: String
    
    init(id: Int64) {
        self.id = id
        self.firstName = ""
        self.lastName = ""
        self.phoneNumber = ""
        self.dateOfBirth = Date()
        self.zipCode = ""
    }
    
    init(id: Int64, firstName: String, phoneNumber: String, lastName: String, dateOfBirth: Date, zipCode: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.dateOfBirth = dateOfBirth
        self.zipCode = zipCode
    }
}
