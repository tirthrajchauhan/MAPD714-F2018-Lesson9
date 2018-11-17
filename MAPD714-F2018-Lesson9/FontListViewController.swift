//
//  FontListViewController.swift
//  MAPD714-F2018-Lesson9
//
//  Created by Tirthrajsinh Chauhan on 2018-11-15.
//  Copyright © 2018 CentennialCollege. All rights reserved.
//

import UIKit

class FontListViewController: UITableViewController {
   
    var fontNames: [String] = []
    var showFavorites: Bool = false
    private var cellPointSize: CGFloat!
    private static let cellIdentifier = "FontName"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let preferredTableViewFont =
            UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        cellPointSize = preferredTableViewFont.pointSize
        tableView.estimatedRowHeight = cellPointSize
        
        if showFavorites{
            navigationItem.rightBarButtonItem = editButtonItem
        }
    }
    
    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont{
        let fontName = fontNames[indexPath.row]
        return UIFont(name: fontName, size: cellPointSize)!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if showFavorites {
            fontNames = FavoritesList.sharedFavoritesList.favorites
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fontNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FontListViewController.cellIdentifier, for: indexPath)
        
        cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath as NSIndexPath)
        cell.textLabel?.text = fontNames[indexPath.row]
        cell.detailTextLabel?.text = fontNames[indexPath.row]
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Get the new view controller using [seque destinationViewController].
        // Pass the selected object to the new view controller
        
        let tableViewCell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: tableViewCell)!
        let font = fontForDisplay(atIndexPath: indexPath as NSIndexPath)
        
        if segue.identifier == "ShowFontSizes"{
            let sizesVC = segue.destination as! FontSizesViewController
            sizesVC.title = font.fontName
            sizesVC.font = font
        } else {
            let infoVC = segue.destination as! FontInfoViewController
            infoVC.title = font.fontName
            infoVC.font = font
            infoVC.favorite =
                FavoritesList.sharedFavoritesList.favorites.contains(font.fontName)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        FavoritesList.sharedFavoritesList.moveItem(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
        fontNames = FavoritesList.sharedFavoritesList.favorites;
    }
    
    
    
    
 
    


}
