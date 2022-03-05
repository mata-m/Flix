//
//  GridDetailsViewController.swift
//  Flix
//
//  Created by Mark on 3/2/22.
//

import UIKit

class GridDetailsViewController: UIViewController {
    var movie: [String:Any]!

    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    @IBAction func didOpenTrailer(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "openTrailerModally", sender: sender)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        let baseUrl = "https://image.tmdb.org/t/p/w154"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        posterView.af.setImage(withURL: posterUrl)
        posterView.layer.borderWidth = 1.0
        posterView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)!
        backdropView.af.setImage(withURL: backdropUrl)
        releaseDateLabel.text = movie["release_date"] as? String
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        /*
        // Find the selected movie
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        // we're just grabbing it so we can pass it the movie. The segue already knows where it's going
        let detailsViewController = segue.destination as! MovieDetailsViewController // we have to cast it so we get access
                                                                              // to the correct methods/fields
        
        // Pass the selected move to the details view controller
        detailsViewController.movie = movie
        tableView.deselectRow(at: indexPath, animated: true)
         */
        let trailerViewController = segue.destination as! TrailerViewController
        //print(movie)
        trailerViewController.movieID = String(movie["id"] as! Int)
        print(trailerViewController.movieID)
    }
    

}
