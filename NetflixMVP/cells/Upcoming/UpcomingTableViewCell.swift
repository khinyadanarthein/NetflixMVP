//
//  UpcomingTableViewCell.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 17/05/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit

class UpcomingTableViewCell: UITableViewCell {
   
    @IBOutlet weak var collectionViewUpcoming: UICollectionView!
    
    static var identifier : String {
        return "UpcomingTableViewCell"
    }
    var upcomingMovieList : [UpcomingMovieVO] = []{
        didSet{
            self.collectionViewUpcoming.reloadData()
        }
    }
    var mDelegate : MovieDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionViewUpcoming.register(UINib(nibName: UpcomingCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: UpcomingCollectionViewCell.identifier)
        
        collectionViewUpcoming.dataSource = self
        collectionViewUpcoming.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension UpcomingTableViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upcomingMovieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingCollectionViewCell.identifier, for: indexPath) as? UpcomingCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.mData = upcomingMovieList[indexPath.row]
    
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}
extension UpcomingTableViewCell : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UserDefaultUtil.shared.saveMovieId(movieId: self.upcomingMovieList[indexPath.row].id)
        UserDefaultUtil.shared.saveMoviePoster(path: self.upcomingMovieList[indexPath.row].posterPath ?? "")
        UserDefaultUtil.shared.saveMovieOverview(overview: self.upcomingMovieList[indexPath.row].overview)
        UserDefaultUtil.shared.saveMovieIsAdult(isAdult: self.upcomingMovieList[indexPath.row].adult)
        UserDefaultUtil.shared.saveMovieDate(date: self.upcomingMovieList[indexPath.row].releaseDate)
        self.mDelegate.onTapMovie(id: self.upcomingMovieList[indexPath.row].id)
    }
}
