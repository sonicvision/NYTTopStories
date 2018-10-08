//
//  TopStoryListViewModel.swift
//  NYTTopStories
//
//  Created by Aarti Rustagi on 07/10/18.
//  Copyright © 2018 Proapptive Solutions. All rights reserved.
//

import Foundation

//Delegate protocol to be implemented by the Controller,
//so that it can be notified whenever there is a change in data
protocol TopStoriesDelegate {
    func topStoriesDidChange()
}

//Protocol to specify what all has to be conformed to in
//regard to showing the Top Stories as a list
protocol TopStoriesViewModelType {
    var topStories: [Topstory] {get}
    func getTopStories()
    var delegate: TopStoriesDelegate? {get set }
}

// ViewModel class which conforms to the TopStoriesViewModelType protocol
// It shall also be notifying controller when the api returns top stories
// so that the same can be updated

class TopStoryListViewModel:TopStoriesViewModelType {
    var delegate: TopStoriesDelegate?
    let topStoryService = TopStoryService()
    
    //The delegate would be notified when the top stories are set
    var topStories: [Topstory] = [] {
        didSet{
            delegate?.topStoriesDidChange()
        }
    }
    
    
    func getTopStories()  {
        topStoryService.fetchTopStories(completionHanlder: { (data) in
            do {
                
                //Below is the parsing logic for extracting the values from the
                //response given by NYT API
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    data, options: [])
                guard let jsonObject = jsonResponse as? [String: Any] else {
                    return
                }
                guard let jsonArray = jsonObject["results"] as? [[String: Any]] else {
                    return
                }
                var topStories : [Topstory] = []
                for dic in jsonArray{
                    guard let abstract = dic["abstract"] as? String else { return }
                    guard let title = dic["title"] as? String else { return }
                    guard let subsection = dic["subsection"] as? String else { return }
                    guard let byline = dic["byline"] as? String else { return }
                    guard let url = dic["url"] as? String else { return }
                    var thumbnailUrl:String = ""
                    var mediumImageUrl:String = ""
                    guard let jsonImageArray = dic["multimedia"] as? [[String: Any]] else {
                        return
                    }
                    for imageDic in jsonImageArray{
                        if let format = imageDic["format"] as? String {
                            if(format == "thumbLarge"){
                                guard let thumbLargeUrl = imageDic["url"] as? String else { return }
                                thumbnailUrl = thumbLargeUrl
                            }
                            if(format == "mediumThreeByTwo210"){
                                guard let mediumImgUrl = imageDic["url"] as? String else { return }
                                mediumImageUrl = mediumImgUrl
                            }
                        } else { return }
                    }
                    
                    topStories.append(Topstory(title: title, author: byline, subsection: subsection, description: abstract, seeMoreUrl: url, smallImageUrl: thumbnailUrl, largeImageUrl: mediumImageUrl))
                }
                //Setting up the created array of top stories into the ViewModel variable
                self.topStories = topStories
            } catch let parsingError {
                print("Error", parsingError)
            }
        })
        
    }
}
