//
//  TopStoryListViewModel.swift
//  NYTTopStories
//
//  Created by Aarti Rustagi on 07/10/18.
//  Copyright © 2018 Proapptive Solutions. All rights reserved.
//

import Foundation

protocol TopStoriesDelegate {
    func topStoriesDidChange()
}

protocol TopStoriesViewModelType {
    var topStories: [Topstory] {get}
    func getTopStories()
    var delegate: TopStoriesDelegate? {get set }
}


class TopStoryListViewModel:TopStoriesViewModelType {
    var delegate: TopStoriesDelegate?
    let topStoryService = TopStoryService()
    
    var topStories: [Topstory] = [] {
        didSet{
            delegate?.topStoriesDidChange()
        }
    }
    
//    init() {
//        print("This is called")
//    }
    func getTopStories()  {
        topStoryService.fetchTopStories(completionHanlder: { (data) in
//            print(data);
            
            //Implement JSON decoding and parsing
            do {
                //                //Decode retrived data with JSONDecoder and assing type of Article object
                //                let articlesData = try JSONDecoder().decode(TopStoryResult.self, from: data)
                //
                //                //Get back to the main queue
                //                DispatchQueue.main.async {
                //                    print(articlesData)
                //                    //self.articles = articlesData
                //                    //self.collectionView?.reloadData()
                //                }
                
                
                //                do{
                //here dataResponse received from a network request
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
                    //guard let mediumThreeByTwo210 = dic["mediumThreeByTwo210"] as? String else { return }
                    //print("\(title):\(abstract):\(subsection):\(byline):\(url)")
                    guard let jsonImageArray = dic["multimedia"] as? [[String: Any]] else {
                        return
                    }
                    for imageDic in jsonImageArray{
                        if let format = imageDic["format"] as? String {
                            if(format == "thumbLarge"){
                                guard let thumbLargeUrl = imageDic["url"] as? String else { return }
                                //print(":\(thumbLargeUrl):")
                                thumbnailUrl = thumbLargeUrl
                            }
                            if(format == "mediumThreeByTwo210"){
                                guard let mediumImgUrl = imageDic["url"] as? String else { return }
                                //print(":\(mediumImgUrl):")
                                mediumImageUrl = mediumImgUrl
                            }
                        } else { return }
                    }
                    
                    topStories.append(Topstory(title: title, author: byline, subsection: subsection, description: abstract, seeMoreUrl: url, smallImageUrl: thumbnailUrl, largeImageUrl: mediumImageUrl))
                }
                self.topStories = topStories
            } catch let parsingError {
                print("Error", parsingError)
            }
        })

    }
}
