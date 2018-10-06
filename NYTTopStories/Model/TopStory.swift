//
//  TopStory.swift
//  NYTTopStories
//
//  Created by Aarti Rustagi on 07/10/18.
//  Copyright © 2018 Proapptive Solutions. All rights reserved.
//

import UIKit

struct TopStoryImage : Codable{
    let url : String
    let format : String
}

struct Topstory : Codable {
    let title : String
    let byline:String
    let subsection:String
    let abstract:String
    let url:String
    let multimedia: [TopStoryImage]
}

struct TopStoryResult : Codable {
    let results : [Topstory]
}
