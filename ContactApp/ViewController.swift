//
//  ViewController.swift
//  ContactApp
//
//  Created by kaleb riley on 7/31/17.
//  Copyright © 2017 kaleb riley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var contactsTableView: UITableView!
    
    fileprivate var contacts = [Contact]()
    fileprivate var selectedContact: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Actions
    @IBAction func addButtonTapped(_ sender: Any) {
        contacts.append(createCurrentContact())
        contactsTableView.insertRows(at: [NSIndexPath(row: contacts.count-1, section: 0) as IndexPath], with: .fade)
    }
    
    @IBAction func updateButtonTapped(_ sender: Any) {
        guard let selectedContact = selectedContact else {
            print("No item selected")
            return
        }
        let id = contacts[selectedContact].id!
        let contact = updateContact(with: id)
        
        contacts.remove(at: selectedContact)
        contacts.insert(contact, at: selectedContact)
        clearFields()
        contactsTableView.reloadData()
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        guard let selectedContact = selectedContact else {
            print("No item selected")
            return
        }
        contacts.remove(at: selectedContact)
        contactsTableView.deleteRows(at: [NSIndexPath(row: contacts.count-1, section: 0) as IndexPath], with: .fade)
        clearFields()
    }
    
    fileprivate func createCurrentContact() -> Contact {
        return updateContact(with: 0)
    }
    
    fileprivate func updateContact(with id: Int64) -> Contact {
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let phoneNumber = phoneTextField.text ?? ""
        let Zip = zipCodeTextField.text ?? ""
        let dob = dateOfBirthTextField.text ?? ""
        clearFields()
        
        return Contact(id: id, firstName: firstName, phoneNumber: phoneNumber, lastName: lastName, dateOfBirth: Date(), zipCode: Zip)
    }
    
    fileprivate func clearFields() {
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        phoneTextField.text = ""
        zipCodeTextField.text = ""
        dateOfBirthTextField.text = ""
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        firstNameTextField.text = contacts[indexPath.row].firstName
        lastNameTextField.text = contacts[indexPath.row].lastName
        dateOfBirthTextField.text = ""
        phoneTextField.text = contacts[indexPath.row].phoneNumber
        zipCodeTextField.text = contacts[indexPath.row].zipCode
        selectedContact = indexPath.row
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell")
        var label: UILabel
        label = cell?.viewWithTag(1) as! UILabel // Name label
        label.text = contacts[indexPath.row].firstName + " " + contacts[indexPath.row].lastName
        
        label = cell?.viewWithTag(2) as! UILabel // Phone label
        label.text = contacts[indexPath.row].phoneNumber
        
        return cell ?? UITableViewCell()
    }
}

