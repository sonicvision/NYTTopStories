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
                let object = objects[indexPath.row] as! NSDate
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }
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
//        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
////        cell.imageView?.image = UIImage(data: data!)
        let newsImage = #imageLiteral(resourceName: "news")

        cell.thumbnailImage.kf.setImage(with: url, placeholder: newsImage, options: nil, progressBlock: nil, completionHandler: nil)
//        let image = UIImage(named: "default_profile_icon")
//        imageView.kf.setImage(with: url, placeholder: image)
//        cell.imageView?.imageFromUrl(urlString: self.topStoriesViewModel.topStories[indexPath.row].smallImageUrl)

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

extension MasterViewController: TopStoriesDelegate {
    func topStoriesDidChange() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            //print(self.topStoriesViewModel.topStories)
        }
    }

}

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(url:url as URL)
            NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) {
                (response: URLResponse?, data: Data?, error: Error?) -> Void in
                if let imageData = data as Data? {
                    self.image = UIImage(data: imageData as Data)
                }
            }
        }
    }
}
