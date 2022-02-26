//
//  ViewController.swift
//  Flix
//
//  Created by Mark on 2/19/22.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var movies = [[String:Any]]() // Creating an empty array of dictionaries that maps strings to anything
    
    override func viewDidLoad() {
        print("Hello")
        // Runs the first time a screen comes up
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                // Get the array of movies
                self.movies = dataDictionary["results"] as! [[String:Any]]
                // We have to tell the table view to update itself now that we've got movies to fill it with
                 // In this case it calls the funcs from below
                self.tableView.reloadData()
                    print(dataDictionary)
                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data

             }
        }
        task.resume()
    }
    
    // For this particular row, give me the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue is asking first if there is another cell off screen then give me that
        // recycled cell or if not create me a new one
        // This is to save on memory and not need to create tons of cells
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let movieOverview = movie["overview"] as! String
        cell.titleLabel?.text = title
        cell.synopsisLabel?.text = movieOverview
        let baseUrl = "https://image.tmdb.org/t/p/w154"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        //cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        cell.posterView.af.setImage(withURL: posterUrl)
        
        return cell
    }
    // Asking for num of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }


}

