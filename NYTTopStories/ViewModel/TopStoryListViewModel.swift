//
//  TopStoryListViewModel.swift
//  NYTTopStories
//
//  Created by Aarti Rustagi on 07/10/18.
//  Copyright © 2018 Proapptive Solutions. All rights reserved.
//

import Foundation

class TopStoryListViewModel {
    
    func fetchTopStories()  {
        let urlString = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=c0488184c7044cb4ac3be54e7d89cc81"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }

            guard let data = data else { return }
            //Implement JSON decoding and parsing
            do {
                //Decode retrived data with JSONDecoder and assing type of Article object
                let articlesData = try JSONDecoder().decode(TopStoryResult.self, from: data)

                //Get back to the main queue
                DispatchQueue.main.async {
                    print(articlesData)
                    //self.articles = articlesData
                    //self.collectionView?.reloadData()
                }

            } catch let jsonError {
                print(jsonError)
            }            }.resume()
    }
}
