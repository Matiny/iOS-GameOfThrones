//
//  EpisodeVC.swift
//  Thrones
//
//  Created by Rave BizzDev on 5/25/20.
//  Copyright © 2020 Rave BizzDev. All rights reserved.
//

import UIKit

class EpisodeVC: UIViewController {
    
    @IBOutlet weak var showImage: UIImageView!
    
    @IBOutlet weak var showDesc: UILabel!
    
    var episode:OneEpisode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //    name, season, number,  airdate, airtime, runtime, summary
        let name = episode!.name
        let season = episode!.season
        let number = episode!.number
        let airdate = episode!.airdate
        let airtime = episode!.airtime
        let runtime = episode!.runtime
        let rawSummary = episode!.summary
        
        let fixedSummary = rawSummary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        
        showDesc.text = "Season \(season), Episode \(number) | \(name)\n\n Aired: \(airtime) on \(airdate) | Runtime: \(runtime) mins\n\n \(fixedSummary)"
        
        let http = episode!.image.medium
        let https = "https" + http.dropFirst(4)
        
        if let url = URL(string: https) {
            
            let data = try? Data(contentsOf: url)
            
            if let imageData = data {
                let image = UIImage(data: imageData)
                showImage.image = image
            }
        }
        
    }
    
}
