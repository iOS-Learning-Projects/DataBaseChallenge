//
//  Task.swift
//  DataBaseChallenge
//
//  Created by Eduardo Vital Alencar Cunha on 20/06/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//

import Foundation

struct Task {
    let name: String
    let description: String
    let limitDate: Date
    let status: TaskStatus

    init(name: String, description: String, limitDate: Date) {
        self.name = name
        self.description = description
        self.limitDate = limitDate
        self.status = .todo
    }
}

enum TaskStatus {
    case todo
    case doing
    case done
}
