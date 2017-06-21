//
//  ViewController.swift
//  DataBaseChallenge
//
//  Created by Eduardo Vital Alencar Cunha on 20/06/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var tasks = [Task]()

    // MARK: - IBOutlets
    @IBOutlet weak var tasksTableView: UITableView!

    // MARK: - IBActions

    // MARK: - ViewController Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newTaskSegue" {
            let taskViewController = segue.destination as! TaskViewController
            taskViewController.delegate = self
        }
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "previewTaskCell") as! PreviewTaskCell
        
        cell.nameLabel.text = self.tasks[indexPath.row].name

        return cell
    }
}

// MARK: - TaskViewControllerDelegate
extension MainViewController: TaskViewControllerDelegate {

    func save(task: Task) -> Bool {
        tasks.append(task)
        self.tasksTableView.reloadData()
        return true
    }

}
