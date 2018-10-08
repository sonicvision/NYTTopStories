//
//  TopStory.swift
//  NYTTopStories
//
//  Created by Aarti Rustagi on 07/10/18.
//  Copyright © 2018 Proapptive Solutions. All rights reserved.
//

// This model will be used to save the values fetched from the NYT API
// They shall be also used by ViewModel to show values on View layer

struct Topstory {
    let title : String
    let author:String
    let subsection:String
    let description:String
    let seeMoreUrl:String
    let smallImageUrl: String
    let largeImageUrl: String
}
