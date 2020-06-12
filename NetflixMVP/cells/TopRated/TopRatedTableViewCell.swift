//
//  TopRatedTableViewCell.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 17/05/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit

class TopRatedTableViewCell: UITableViewCell {
    
    static var identifier : String {
        return "TopRatedTableViewCell"
    }
    
    @IBOutlet weak var collectionViewTopRated: UICollectionView!
    var mDelegate : MovieDelegate!
    
    var topRatedMovieList : [TopRatedMovieVO] = []{
        didSet{
            self.collectionViewTopRated.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionViewTopRated.register(UINib(nibName: TopRatedCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TopRatedCollectionViewCell.identifier)
        
        
        collectionViewTopRated.dataSource = self
        collectionViewTopRated.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension TopRatedTableViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.topRatedMovieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopRatedCollectionViewCell.identifier, for: indexPath) as? TopRatedCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.mData = self.topRatedMovieList[indexPath.row]
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}
extension TopRatedTableViewCell : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.mDelegate.onTapMovie(id: self.topRatedMovieList[indexPath.row].id)
    }
}
