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

    init() {
        self.realm = try! Realm()
    }

    func all() -> Results<Task> {
        return self.realm.objects(Task.self)
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

    private func save(_ task: Task, updatingValues update: Bool = false) {
        // Set task ID
        if (!update) { task.id = self.all().count }

        try! realm.write {
            realm.add(task, update: update)
        }

    } 
}
