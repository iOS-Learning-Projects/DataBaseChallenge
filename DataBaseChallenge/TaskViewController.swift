//
//  TaskViewController.swift
//  DataBaseChallenge
//
//  Created by Eduardo Vital Alencar Cunha on 20/06/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//

import UIKit

class TaskViewController: UITableViewController {
    // MARK: - Properties
    var delegate: TaskViewControllerDelegate?

    // MARK: - IBOutlets
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var limitDatePicker: UIDatePicker!

    // MARK: - IBActions
    @IBAction func saveTask(_ sender: UIBarButtonItem) {
        if  let name = self.nameTextField.text,
            let description = self.descriptionTextView.text,
            !name.isEmpty, !description.isEmpty {

            let limitDate = self.limitDatePicker.date
            let task = Task(name: name, description: description, limitDate: limitDate)

            if (self.delegate?.save(task: task))! {
                self.navigationController?.popViewController(animated: true)
            } else {
                print("Failed to save task")
            }
        }
    }

    @IBAction func popViewController(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - UIViewController Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        self.descriptionTextView.layer.borderWidth = 1
        self.descriptionTextView.layer.borderColor = UIColor.gray.cgColor
    }

}

protocol TaskViewControllerDelegate {
    func save(task: Task) -> Bool
}
