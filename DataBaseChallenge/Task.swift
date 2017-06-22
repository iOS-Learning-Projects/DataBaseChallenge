//
//  Task.swift
//  DataBaseChallenge
//
//  Created by Eduardo Vital Alencar Cunha on 20/06/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var textDescription = ""
    dynamic var limitDate = Date()
    private dynamic var status = TaskStatus.RawValue()

    var statusEnum: TaskStatus {
        get {
            return TaskStatus(rawValue: self.status)!
        }
        set {
            self.status = newValue.rawValue
        }
    }

    override static func primaryKey() -> String {
        return "id"
    }

    convenience init(name: String, description: String, limitDate: Date, id: Int?) {
        self.init()

        if let existingId = id { self.id = existingId }

        self.name = name
        self.textDescription = description
        self.limitDate = limitDate
        self.statusEnum = .todo
    }
}

enum TaskStatus: String {
    case todo
    case doing
    case done
}

