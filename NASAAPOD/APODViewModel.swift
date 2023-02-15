//
//  APODViewModel.swift
//  NASAAPOD
//
//  Created by Malik Em on 14.02.2023.
//

import Foundation

final class APODViewModel {
    
    let copyright: String
    let date: String
    let explanation: String
    var hdurl: URL?
    var title: String
    var imageData: Data? = nil
    
    init(
        copyright: String,
        date: String,
        explanation: String,
        hdurl: URL?,
        title: String
    ) {
        self.copyright = copyright
        self.date = date
        self.explanation = explanation
        self.hdurl = hdurl
        self.title = title
    }    
}
