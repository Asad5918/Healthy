//
//  ListViewController.swift
//  Healthy
//
//  Created by Md Asadullah on 23/11/23.
//

import UIKit

class ListViewController: UIViewController {

    var tableView: UITableView!
    var data: [String] = [""]
    var activityIndicator: UIActivityIndicatorView!
    
    var item: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the UITableView
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        // Set the data source and delegate
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40

        // Register a cell class or a cell reuse identifier if needed
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: Constant.ListCellIdentifier)

        // Add the table view to the view hierarchy
        view.addSubview(tableView)

        // Set up constraints for the table view
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Set up navigation controller
        let navigationController = UINavigationController(rootViewController: self)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.topItem?.title = Constant.appTitle

        // Set the navigation controller as the root view controller
        UIApplication.shared.windows.first?.rootViewController = navigationController
        
        Utility.showLoader(onView: self.view)
        getList()
    }
    
    
    func getList() {
        // Define the URL
        let apiUrl = URL(string: Constant.baseUrlList)!

        // Create a URLSession
        let session = URLSession.shared

        // Create a data task to make the request
        let task = session.dataTask(with: apiUrl) { (data, response, error) in
            Utility.hideLoader()
            // Check for errors
            if let error = error {
                print("Error: \(error)")
                let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                    return
                }))
                self.present(alert, animated: true)
            }

            // Check if data is available
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                // Decode the JSON data using the ApiResponse model
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(ApiResponse.self, from: data)

                // Access the data in the response
                self.item  = apiResponse.Result.Items.Item
                self.data = self.item.map({$0.Title})
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Error decoding JSON: \(error)")
                let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                    return
                }))
                self.present(alert, animated: true)
            }
        }

        // Start the data task
        task.resume()
    }
}


extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        cell.configure(with: data[indexPath.row])
        return cell
    }

    
    // MARK: - UITableViewDelegate methods

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let Ids = self.item.map({$0.Id})
        detailViewController.urlID = Ids[indexPath.row]
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
