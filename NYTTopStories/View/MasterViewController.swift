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


    override func viewDidLoad() {
        
        super.viewDidLoad()
        topStoriesViewModel.getTopStories()
        topStoriesViewModel.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc
    func insertNewObject(_ sender: Any) {
        objects.insert(NSDate(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.topStory = self.topStoriesViewModel.topStories[indexPath.row]
//                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
//                controller.navigationItem.leftItemsSupplementBackButton = true
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
        }else{
            self.tableView.separatorStyle = .singleLine
        }
        
        return self.topStoriesViewModel.topStories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TopStoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TopStoryTableViewCell

        cell.author.text = self.topStoriesViewModel.topStories[indexPath.row].author
        cell.title.text = self.topStoriesViewModel.topStories[indexPath.row].title
        
        let url = URL(string: self.topStoriesViewModel.topStories[indexPath.row].smallImageUrl)
        let newsImage = #imageLiteral(resourceName: "news")

        cell.thumbnailImage.kf.setImage(with: url, placeholder: newsImage, options: nil, progressBlock: nil, completionHandler: nil)

        return cell
    }
}

extension MasterViewController: TopStoriesDelegate {
    func topStoriesDidChange() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}
