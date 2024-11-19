//
//  TaskViewModel.swift
//  NonStoryboardApp
//
//  Created by FabioCunha on 07/11/24.
//  Copyright © 2024 elmland.blog. All rights reserved.
//


import Foundation

class TaskViewModel {
    private var tasks: [Task] = []
    
    var tasksCount: Int {
        return tasks.count
    }
    
    func task(at index: Int) -> Task {
        return tasks[index]
    }
    
    func addTask(title: String) {
        let newTask = Task(title: title, isCompleted: false)
        tasks.append(newTask)
    }
}
