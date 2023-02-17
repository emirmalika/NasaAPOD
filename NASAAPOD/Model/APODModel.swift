//
//  APOD.swift
//  NASAAPOD
//
//  Created by Malik Em on 10.02.2023.
//

import Foundation

typealias Photo = [Photos]

struct Photos: Codable {
    let copyright: String?
    let date: String?
    let explanation: String?
    let hdurl: String?
    let title: String?
}

