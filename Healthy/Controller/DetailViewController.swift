//
//  DetailViewController.swift
//  Healthy
//
//  Created by Md Asadullah on 23/11/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCategories: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var stackView: UIStackView!
    var activityIndicator: UIActivityIndicatorView!
    var baseUrl = Constant.baseUrlDetail
    var urlID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        // Create an activity indicator
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true

        // Add the activity indicator to your view
        view.addSubview(activityIndicator)
        
        Utility.showLoader()
        getDetails()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func getDetails() {
        // Define the URL
        let apiUrl = URL(string: baseUrl + urlID)!

        // Create a URLSession
        let session = URLSession.shared

        // Create a data task to make the request
        let task = session.dataTask(with: apiUrl) { (data, response, error) in
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
                let apiResponse = try decoder.decode(DetailApiResponse.self, from: data)
                Utility.hideLoader()
                // Access the data in the response
                print("Title: \(apiResponse.Result.Resources.Resource.first?.Title ?? "")")
                let resource = apiResponse.Result.Resources.Resource
                DispatchQueue.main.async {
                    self.lblTitle.text = resource.first?.Title ?? ""
                    self.lblCategories.text = resource.first?.Categories
                }
                
                if let imageUrlString = apiResponse.Result.Resources.Resource.first?.ImageUrl {
                    if let imageUrl = URL(string: imageUrlString) {
                        // Download image data asynchronously
                        DispatchQueue.global().async {
                            if let imageData = try? Data(contentsOf: imageUrl) {
                                // Update UI on the main thread
                                DispatchQueue.main.async {
                                    // Set the image to the imageView
                                    self.imgView.image = UIImage(data: imageData)
                                }
                            }
                        }
                    }
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
