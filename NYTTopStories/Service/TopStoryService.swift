//
//  TopStoryService.swift
//  NYTTopStories
//
//  Created by Aarti Rustagi on 08/10/18.
//  Copyright © 2018 Proapptive Solutions. All rights reserved.
//

import Foundation

class TopStoryService {
    
    func fetchTopStories(completionHanlder: @escaping (_ topStoriesData: Data ) -> Void){
        let urlString = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=c0488184c7044cb4ac3be54e7d89cc81"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            completionHanlder(data)

        }.resume()
    }
}

