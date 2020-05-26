//
//  ThroneData.swift
//  Thrones
//
//  Created by Matiny on 5/25/20.
//  Copyright © 2020 Matiny. All rights reserved.
//

import Foundation

struct Main: Decodable {
    let _embedded: EpisodeList
}

struct EpisodeList: Decodable {
    let episodes: [OneEpisode]
}

struct OneEpisode: Decodable {
    let name: String
    let season: Int
    let number: Int
    let airdate: String
    let airtime: String
    let runtime: Int
    let summary: String
    let image: Image
}

struct Image: Decodable {
    let medium: String
}
