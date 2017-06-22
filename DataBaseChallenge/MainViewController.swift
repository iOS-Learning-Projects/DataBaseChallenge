//
//  ViewController.swift
//  DataBaseChallenge
//
//  Created by Eduardo Vital Alencar Cunha on 20/06/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var tasks = TaskController()

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
        return tasks.all().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "previewTaskCell") as! PreviewTaskCell
        
        cell.nameLabel.text = self.tasks.findBy(id: indexPath.row).name

        return cell
    }

}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskViewController = self.storyboard?.instantiateViewController(withIdentifier: "taskViewController") as! TaskViewController

        taskViewController.task = self.tasks.findBy(id: indexPath.row) // FIXME
        taskViewController.delegate = self

        self.navigationController?.pushViewController(taskViewController, animated: true)
    }
}

// MARK: - TaskViewControllerDelegate
extension MainViewController: TaskViewControllerDelegate {

    func save(task: Task) -> Bool {
        self.tasks.create(task)
        self.tasksTableView.reloadData()
        return true
    }

    func update(task: Task) -> Bool {
        self.tasks.update(task: task)
        self.tasksTableView.reloadData()
        return true
    }

}
