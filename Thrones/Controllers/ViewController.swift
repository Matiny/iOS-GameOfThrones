//
//  ViewController.swift
//  Thrones
//
//  Created by Rave BizzDev on 5/25/20.
//  Copyright © 2020 Rave BizzDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var tableItems: UITableView!
    
    var resultArray: [OneEpisode] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        performRequest(urlString: "https://api.tvmaze.com/shows/82?embed=seasons&embed=episodes")
        
        tableItems.delegate = self
        tableItems.dataSource = self
        tableItems.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    func parseJSON(throneData: Data) {
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(Main.self, from: throneData)
                let episodeArray = decodedData._embedded.episodes

                DispatchQueue.main.async {
                    self.resultArray = episodeArray
                    self.tableItems.reloadData()
                }
                
            } catch {
                print(error)
            }
        }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                // Unwrap episodeList since parseJSON returns an optional [OneEpisode]
                if let safeData = data {
                    self.parseJSON(throneData: safeData)
                }
            }
            
            task.resume()
        }
    }
}

extension ViewController: UITableViewDelegate {
    
    // didSelectRowAt is the onclick function for table cells
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Grabs the next view and pushes to it
        
        let nextVC = storyboard.instantiateViewController(identifier: "EpisodeVC") as! EpisodeVC

        navigationController?.pushViewController(nextVC, animated: true)
        
        nextVC.episode = resultArray[tableView.indexPathForSelectedRow!.row]
        
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let episodeInfo = resultArray[indexPath.row]
        
        cell.textLabel?.text = "\(episodeInfo.season)x\(episodeInfo.number): \(episodeInfo.name)"
        
        return cell
    }
    
}

