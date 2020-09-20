//
//  CoursesViewController.swift
//  Networking
//
//  Created by Ярослав Карпунькин on 14.09.2020.
//

import UIKit

class CoursesViewController: UIViewController {
    private var courses: [Course] = [Course]()
    private var courseName: String?
    private var courseUrl: String?
    private let url = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
    private let postRequestUrl = "https://jsonplaceholder.typicode.com/posts"
    private let putRequestUrl = "https://jsonplaceholder.typicode.com/posts/1"
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func fetchData() {
        NetworkManager.fetchData(url: url) { (courses) in
            self.courses = courses
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }


    }
    
    func fetchDataWithAlomofire(){
        AlomofireNetworkRequest.sendRequest(url: url) { (courses) in
            self.courses = courses
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func postRequest() {
        AlomofireNetworkRequest.postRequest(url: postRequestUrl) { (courses) in
            self.courses = courses
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func putRequest(){
        AlomofireNetworkRequest.putRequest(url: putRequestUrl) { (courses) in
            self.courses = courses
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func configureCell(cell: TableViewCell, for indexPath: IndexPath){
        let course = courses[indexPath.row]
        cell.courseNameLabel.text = course.name
        
        if let numberOfLessons = course.numberOfLessons {
            cell.numberOfLessons.text = "Number of lessons: \(numberOfLessons)"
        }
        
        if let numberOfTests = course.numberOfTests{
            cell.numberOfTests.text = "Number of tests: \(numberOfTests)"
        }
        
        DispatchQueue.global().async {
            guard let stringUrl = course.imageUrl else  { return }
            guard let imageUrl = URL(string: stringUrl) else  { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            
            DispatchQueue.main.async {
                cell.courseImage.image = UIImage(data: imageData)
            }
        }

        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let webViewController = segue.destination as? WebViewController else  { return }
        
        webViewController.selectedCourse = courseName
        if let url = courseUrl {
            webViewController.courseURL = url
        }
        
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
        configureCell(cell: cell, for: indexPath)
        
        return cell
    }
}

// MARK: Table View Delegate

extension CoursesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = courses[indexPath.row]
        
        courseUrl = course.link
        courseName = course.name
        
        performSegue(withIdentifier: "Description", sender: self)
    }
}

