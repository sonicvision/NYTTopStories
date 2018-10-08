//
//  DetailViewController.swift
//  NYTTopStories
//
//  Created by Aarti Rustagi on 07/10/18.
//  Copyright © 2018 Proapptive Solutions. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var newsDescription: UITextView!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var largeImage: UIImageView!
    var topStory : Topstory!
    
    //The configureView function configures the detail view
    //based on the news selected on the previous screen
    func configureView() {
        if let detail = topStory {
            author.text = detail.author
            newsTitle.text = detail.title
            newsDescription.text = detail.description
            
            let url = URL(string: detail.largeImageUrl)
            let newsImage = UIImage(named: "news")
            largeImage.kf.setImage(with: url, placeholder: newsImage, options: nil, progressBlock: nil, completionHandler: nil)
            
            if(detail.subsection.count > 0){
                self.title = detail.subsection
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seeMore" {
            let controller = segue.destination as? NewsWebViewController
            controller?.newsUrl = self.topStory.seeMoreUrl
        }
    }
    
}

