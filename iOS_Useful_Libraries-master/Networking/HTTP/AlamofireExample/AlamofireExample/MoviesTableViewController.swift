//
//  MoviesTableViewController.swift
//  AlamofireExample
//
//  Created by wannabewize on 2018. 6. 20..
//  Copyright © 2018년 wannabewize. All rights reserved.
//

import UIKit
import Alamofire

struct Movie {
    var title: String
    var director: String
    var year: Int
}

class MoviesTableViewController: UITableViewController {
    
    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func resolveMovies() {
        movies.removeAll()
        
        Alamofire.request("\(serverAddr)/movies").responseJSON { (response) in
            
            guard response.error == nil else {
                print("Error : \(response.error)")
                return
            }
            
            if let json = response.result.value as? [String: Any],
               let count = json["count"] as? Int,
               let data = json["data"] as? [ [String:Any]] {
                
                    print("count : \(count)")
                for item in data {
                    if let title = item["title"] as? String,
                       let director = item["director"] as? String,
                       let year = item["year"] as? Int {
                       let movie = Movie(title: title, director: director, year: year)
                       self.movies.append(movie)
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.resolveMovies()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)

        let item = movies[indexPath.row]
        cell.textLabel?.text = "\(item.title) (\(item.year))"
        cell.detailTextLabel?.text = item.director

        return cell
    }
}
