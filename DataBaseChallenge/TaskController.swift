//
//  TaskController.swift
//  DataBaseChallenge
//
//  Created by Eduardo Vital Alencar Cunha on 22/06/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//

import Foundation
import RealmSwift

struct TaskController {
    private var realm: Realm
    private var tasks: Results<Task>

    init() {
        self.realm = try! Realm()
        self.tasks = self.realm.objects(Task.self)
    }

    func all() -> Results<Task> {
        return self.tasks
    }

    func create(_ task: Task) {
        self.save(task)
    }

    func findBy(id: Int) -> Task {
        return self.realm.object(ofType: Task.self, forPrimaryKey: id)!
    }

    func update(task: Task) {
        self.save(task, updatingValues: true)
    }

    func deleteTaskBy(id: Int) {
        try! self.realm.write {
            realm.delete(self.tasks[id])
        }
    }

    private func save(_ task: Task, updatingValues update: Bool = false) {
        // Set task ID
        if (!update) { task.id = self.tasks.count }

        try! realm.write {
            realm.add(task, update: update)
        }

    }

    subscript(index: Int) -> Task {
        get {
            return self.tasks[index]
        }
    }
}
