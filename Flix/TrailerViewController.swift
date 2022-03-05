//
//  TrailerViewController.swift
//  Flix
//
//  Created by Mark on 3/4/22.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController, WKUIDelegate {
    
    var movieID = ""
    var videos = [[String:Any]]()
    @IBOutlet weak var webView: WKWebView!
    override func loadView() {
            let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            webView.uiDelegate = self
            view = webView
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                // Get the array of videos
                 print(dataDictionary)
                 self.videos = dataDictionary["results"] as! [[String:Any]]
                 
                 // We have to access the videos here since if we did this outside the task
                 // there isn't a guarantee that the videos would be loaded into
                 // the video var yet (this closure is on another thread)
                 let firstVideo = self.videos[0]
                 let key = firstVideo["key"] as! String
                 let videoURL = URL(string:"https://www.youtube.com/watch?v=\(key)")
                 let myRequest = URLRequest(url: videoURL!)
                 self.webView.load(myRequest)
             }
        }
        task.resume() // Start the task from above on another thread
                     
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
