//
//  MovieViewController.swift
//  theMovie-app
//
//  Created by Adriel Alves on 16/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import UIKit

struct Item {
    var imageName: String
    
}

class MovieViewController: UIViewController {
    
    @IBOutlet weak var lbSearch: UITextField!
    @IBOutlet weak var cvMoviesList: UICollectionView!
    
    var items: [Item] = [Item(imageName: "1")]
    
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    let cellIndentifier = "ItemCollectionViewCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func setupCollectionView() {
        cvMoviesList.delegate = self
        cvMoviesList.dataSource = self
        let nib = UINib(nibName: "ItemCollectionViewCell", bundle: nil)
        cvMoviesList.register(nib, forCellWithReuseIdentifier: cellIndentifier)
    }
    
    private func setupCollectionViewItemSize() {
        
    }

}

extension MovieViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
  
}

extension MovieViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIndentifier, for: indexPath) as!
            ItemCollectionViewCell
        
       cell.imageView.image = UIImage(named: items[indexPath.item].imageName)
        return cell
    }
    
}
