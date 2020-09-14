//
//  CoursesViewController.swift
//  Networking
//
//  Created by Ярослав Карпунькин on 14.09.2020.
//

import UIKit

class CoursesViewController: UIViewController {
    private var courses: [Course] = [Course]()
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()

        
    }
    
    func fetchData() {
        let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_courses"

        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data else  { return }
            
            do {
                self.courses  = try JSONDecoder().decode([Course].self, from: data)
                
                print("\(self.courses)")
            } catch let error {
                print("\(error) error serialization json")
            }
            
        }).resume()
    }

}
// MARK: Table View Data Source

extension CoursesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(courses.count)
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        
        return cell
    }
}

// MARK: Table View Delegate

extension CoursesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

