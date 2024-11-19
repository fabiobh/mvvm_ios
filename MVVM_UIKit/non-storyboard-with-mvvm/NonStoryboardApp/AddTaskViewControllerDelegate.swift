//
//  AddTaskViewControllerDelegate.swift
//  NonStoryboardApp
//
//  Created by FabioCunha on 07/11/24.
//  Copyright © 2024 elmland.blog. All rights reserved.
//


import UIKit

protocol AddTaskViewControllerDelegate: AnyObject {
    func didAddTask(title: String)
}

class AddTaskViewController: UIViewController {
    
    weak var delegate: AddTaskViewControllerDelegate?
    private let textField = UITextField()
    private let saveButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Add New Task"
        
        // Configurando o TextField
        textField.placeholder = "Enter task title"
        textField.borderStyle = .roundedRect
        view.addSubview(textField)
        
        // Configurando o botão de salvar
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        view.addSubview(saveButton)
        
        // Configurando Auto Layout
        textField.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            saveButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func didTapSave() {
        guard let title = textField.text, !title.isEmpty else { return }
        delegate?.didAddTask(title: title)
        dismiss(animated: true)
    }
}
