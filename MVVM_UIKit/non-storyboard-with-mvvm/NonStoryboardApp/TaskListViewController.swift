//
//  TaskListViewController.swift
//  NonStoryboardApp
//
//  Created by FabioCunha on 07/11/24.
//  Copyright © 2024 elmland.blog. All rights reserved.
//


import UIKit

class TaskListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableView = UITableView()
    private let addButton = UIButton(type: .system)
    private let viewModel = TaskViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "To-Do List"
        
        // Configurando o TableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TaskCell")
        view.addSubview(tableView)
        
        // Configurando o botão de adicionar
        addButton.setTitle("Add Task", for: .normal)
        addButton.addTarget(self, action: #selector(didTapAddTask), for: .touchUpInside)
        view.addSubview(addButton)
        
        // Configurando Auto Layout
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -10),
            
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func didTapAddTask() {
        let addTaskVC = AddTaskViewController()
        addTaskVC.delegate = self
        present(addTaskVC, animated: true)
    }
    
    // MARK: - TableView DataSource e Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tasksCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        let task = viewModel.task(at: indexPath.row)
        cell.textLabel?.text = task.title
        return cell
    }
}

extension TaskListViewController: AddTaskViewControllerDelegate {
    func didAddTask(title: String) {
        viewModel.addTask(title: title)
        tableView.reloadData()
    }
}
