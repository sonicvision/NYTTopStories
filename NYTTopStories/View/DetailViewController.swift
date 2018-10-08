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
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = topStory {
            author.text = detail.author
            newsTitle.text = detail.title
            newsDescription.text = detail.description
            let url = URL(string: detail.largeImageUrl)
            let newsImage = #imageLiteral(resourceName: "news")
            
            largeImage.kf.setImage(with: url, placeholder: newsImage, options: nil, progressBlock: nil, completionHandler: nil)
            if(detail.subsection.count > 0){
                self.title = detail.subsection
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seeMore" {
//            let controller = (segue.destination as! UINavigationController).topViewController as! NewsWebViewController
            let controller = segue.destination as? NewsWebViewController
            controller?.newsUrl = self.topStory.seeMoreUrl
            
        }
    }
    
}

