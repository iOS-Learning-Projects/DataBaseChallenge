//
//  ViewController.swift
//  DataBaseChallenge
//
//  Created by Eduardo Vital Alencar Cunha on 20/06/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    var tasks = TaskController()
    var filteredTasks: Results<Task>?
    var shouldShowSearchResults = false
    var searchController: UISearchController!

    // MARK: - IBOutlets
    @IBOutlet weak var tasksTableView: UITableView!

    // MARK: - IBActions


    // MARK: - Functions
    func filterTasksBy(name: String) {
        self.filteredTasks = self.tasks.all().filter("name CONTAINS[c]'\(name)'")
    }

    func configureSearchController() {
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Busque a tarefa pelo nome aqui..."
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.sizeToFit()

        // Place the search bar into tableview header
        self.tasksTableView.tableHeaderView = searchController.searchBar
    }

    // MARK: - ViewController Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureSearchController()
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
        if shouldShowSearchResults {
            if let filteredTasks = self.filteredTasks {
                return filteredTasks.count
            } else {
                return 0
            }
        } else {
            return tasks.all().count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "previewTaskCell") as! PreviewTaskCell

        if shouldShowSearchResults {
            cell.nameLabel.text = self.filteredTasks![indexPath.row].name
        } else {
            cell.nameLabel.text = self.tasks[indexPath.row].name
        }

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.deleteTaskBy(id: indexPath.row)
            tableView.reloadData()
        }
    }

}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskViewController = self.storyboard?.instantiateViewController(withIdentifier: "taskViewController") as! TaskViewController

        taskViewController.task = self.tasks[indexPath.row]
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

// MARK: - UISearchResultsUpdating
extension MainViewController: UISearchResultsUpdating  {
    func updateSearchResults(for searchController: UISearchController) {
        self.filterTasksBy(name: searchController.searchBar.text!)
        self.tasksTableView.reloadData()
    }
}

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.shouldShowSearchResults = true
        self.tasksTableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.shouldShowSearchResults = false
        self.tasksTableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.tasksTableView.resignFirstResponder()
    }
}
