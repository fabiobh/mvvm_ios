# mvvm_ios
Example of code of how to use MVVM on iOS app

## Data Binding Example

Data binding is a core concept in MVVM that allows the View to automatically update when the ViewModel's state changes. In this project, we demonstrate a simple and effective way to achieve this using **Closures**.

### How it works

1.  **ViewModel**: Defines a closure property (e.g., `onTasksUpdated`) and calls it whenever its data changes.
2.  **View (ViewController)**: Binds to this closure, defining what should happen when the data updates (typically reloading the UI).

### Code Demonstration

**ViewModel (`TaskViewModel.swift`)**

```swift
class TaskViewModel {
    // 1. Define the closure
    var onTasksUpdated: (() -> Void)?
    
    // ...
    
    func addTask(title: String) {
        let newTask = Task(title: title, isCompleted: false)
        tasks.append(newTask)
        
        // 2. Notify the View
        onTasksUpdated?()
    }
}
```

**View (`TaskListViewController.swift`)**

```swift
class TaskListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    private func setupBindings() {
        // 3. Bind to the closure
        viewModel.onTasksUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}
```

### Two-Way Binding (View → ViewModel)

The example above shows one-way binding (ViewModel → View). For a complete MVVM implementation, the View should also update the ViewModel. Here's how to achieve two-way binding:

**ViewModel with two-way binding:**

```swift
class TaskViewModel {
    // ViewModel → View
    var onSearchTextChanged: ((String) -> Void)?
    
    // Property that notifies the View when changed
    var searchText: String = "" {
        didSet {
            filterTasks(by: searchText)
        }
    }
    
    // View → ViewModel: Called by the View
    func updateSearchText(_ text: String) {
        searchText = text
    }
}
```

**ViewController binding to TextField:**

```swift
class TaskListViewController: UIViewController, UITextFieldDelegate {
    
    private let searchField = UITextField()
    
    private func setupBindings() {
        // ViewModel → View
        viewModel.onSearchTextChanged = { [weak self] text in
            self?.searchField.text = text
        }
        
        // View → ViewModel
        searchField.addTarget(self, action: #selector(searchTextDidChange), for: .editingChanged)
    }
    
    @objc private func searchTextDidChange() {
        viewModel.updateSearchText(searchField.text ?? "")
    }
}
```

This pattern ensures that:
- When the **ViewModel** changes, the **View** updates automatically
- When the **user interacts** with the View, the **ViewModel** is updated

### External Resources

For more advanced data binding techniques in iOS, consider exploring:
- [Combine Framework](https://developer.apple.com/documentation/combine) (Native Apple framework)
- [RxSwift](https://github.com/ReactiveX/RxSwift) (Popular reactive programming library)
