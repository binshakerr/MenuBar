//
//  ViewController.swift
//  MenuBar2
//
//  Created by eslam shaker on 9/2/18.
//  Copyright © 2018 eslam shaker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var countriesTable: UITableView!
    @IBOutlet weak var menuCollection: UICollectionView!
    
    let countriesArray = [["China", "Japan", "Korea"],
                          ["Egypt", "Sudan", "South Africa"],
                          ["Spain", "Netherlands", "France"]]
    var selectedArray = [String]()
    var selectedIndex = 0
    var selectedIndexPath = IndexPath(item: 0, section: 0)
    let menuTitles = ["Asia", "Africa", "Europe"]
    var indicatorView = UIView()
    let indicatorHeight : CGFloat = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedArray = countriesArray[selectedIndex]
        menuCollection.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .centeredVertically)
        
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
        
        indicatorView.backgroundColor = .white
        indicatorView.frame = CGRect(x: menuCollection.bounds.minX, y: menuCollection.bounds.maxY - indicatorHeight, width: menuCollection.bounds.width / CGFloat(menuTitles.count), height: indicatorHeight)
        menuCollection.addSubview(indicatorView)
    }
    
    @objc func swipeAction(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            if selectedIndex < menuTitles.count - 1 {
                selectedIndex += 1
            }
        } else {
            if selectedIndex > 0 {
                selectedIndex -= 1
            }
        }
        
        selectedIndexPath = IndexPath(item: selectedIndex, section: 0)
        menuCollection.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .centeredVertically)
        refreshContent()
    }
    
    
    func refreshContent(){
        selectedArray = countriesArray[selectedIndex]
        countriesTable.reloadData()
        
        let desiredX = (menuCollection.bounds.width / CGFloat(menuTitles.count)) * CGFloat(selectedIndex)
        
        UIView.animate(withDuration: 0.3) {
             self.indicatorView.frame = CGRect(x: desiredX, y: self.menuCollection.bounds.maxY - self.indicatorHeight, width: self.menuCollection.bounds.width / CGFloat(self.menuTitles.count), height: self.indicatorHeight)
        }
    }

}



extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = selectedArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuTitles.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.setupCell(text: menuTitles[indexPath.item])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / CGFloat(menuTitles.count), height: collectionView.bounds.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        refreshContent()
    }
}







