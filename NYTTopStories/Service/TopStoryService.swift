//
//  TopStoryService.swift
//  NYTTopStories
//
//  Created by Aarti Rustagi on 08/10/18.
//  Copyright © 2018 Proapptive Solutions. All rights reserved.
//

import Foundation

// This Service is used for fetching top stories from NYT API


class TopStoryService {
    
    func fetchTopStories(completionHanlder: @escaping (_ topStoriesData: Data ) -> Void){
        
        //Fetch the value of API_URL and API_KEY from the plist
        let urlString = "\(UtilityService.fetchValueFromPlist(keyName: "NYT_APP_URL"))?api-key=\(UtilityService.fetchValueFromPlist(keyName: "NYT_API_KEY"))"
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

