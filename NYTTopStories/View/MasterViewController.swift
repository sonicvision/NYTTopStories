//
//  MasterViewController.swift
//  NYTTopStories
//
//  Created by Aarti Rustagi on 07/10/18.
//  Copyright © 2018 Proapptive Solutions. All rights reserved.
//

import UIKit
import Kingfisher

class MasterViewController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    
    var topStoriesViewModel:TopStoryListViewModel =  TopStoryListViewModel()
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topStoriesViewModel.getTopStories()
        topStoriesViewModel.delegate = self
        spinner.startAnimating()
        tableView.backgroundView = spinner
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = segue.destination as! DetailViewController
                controller.topStory = self.topStoriesViewModel.topStories[indexPath.row]
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.topStoriesViewModel.topStories.count==0){
            self.tableView.separatorStyle = .none
            return 0
        }else{
            self.tableView.separatorStyle = .singleLine
            spinner.stopAnimating()
            return self.topStoriesViewModel.topStories.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:TopStoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TopStoryTableViewCell
        
        cell.author.text = self.topStoriesViewModel.topStories[indexPath.row].author
        cell.title.text = self.topStoriesViewModel.topStories[indexPath.row].title
        
        let url = URL(string: self.topStoriesViewModel.topStories[indexPath.row].smallImageUrl)
        let newsImage = UIImage(named: "news")
        
        cell.thumbnailImage.kf.setImage(with: url, placeholder: newsImage, options: nil, progressBlock: nil, completionHandler: nil)
        return cell
    }
}
// Delegate function will be invoked by View Model when the Top Stories are fetched
extension MasterViewController: TopStoriesDelegate {
    func topStoriesDidChange() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}
