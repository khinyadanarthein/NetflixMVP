//
//  TrendingTableViewCell.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 03/05/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit

class TrendingTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionViewTrending: UICollectionView!
    
    static var identifier : String {
        return "TrendingTableViewCell"
    }
    
    var trendingMovieList : [TrendingMovieVO] = []{
        didSet{
            self.collectionViewTrending.reloadData()
        }
    }
    var mDelegate : MovieDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionViewTrending.register(UINib(nibName: TrendingCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TrendingCollectionViewCell.identifier)
        
        collectionViewTrending.dataSource = self
        collectionViewTrending.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}

extension TrendingTableViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("trending list \(self.trendingMovieList.count)")
        return self.trendingMovieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCollectionViewCell.identifier, for: indexPath) as? TrendingCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.mData = self.trendingMovieList[indexPath.row]
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}
extension TrendingTableViewCell : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UserDefaultUtil.shared.saveMovieId(movieId: self.trendingMovieList[indexPath.row].id)
        UserDefaultUtil.shared.saveMoviePoster(path: self.trendingMovieList[indexPath.row].posterPath)
        UserDefaultUtil.shared.saveMovieOverview(overview: self.trendingMovieList[indexPath.row].overview)
        UserDefaultUtil.shared.saveMovieIsAdult(isAdult: self.trendingMovieList[indexPath.row].adult)
        UserDefaultUtil.shared.saveMovieDate(date: self.trendingMovieList[indexPath.row].releaseDate)
        self.mDelegate.onTapMovie(id: self.trendingMovieList[indexPath.row].id)
    }
}
