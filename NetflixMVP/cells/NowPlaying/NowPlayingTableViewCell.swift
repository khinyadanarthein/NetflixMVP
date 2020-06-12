//
//  NowPlayingTableViewCell.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 16/05/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit

class NowPlayingTableViewCell: UITableViewCell {

    static var identifier : String {
        return "NowPlayingTableViewCell"
    }
    
    @IBOutlet weak var collectionViewNowPlaying: UICollectionView!
    
    var nowPlayMovieList : [NowPlayingMovieVO] = []{
        didSet{
            self.collectionViewNowPlaying.reloadData()
        }
    }
    var mDelegate : MovieDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionViewNowPlaying.register(UINib(nibName: NowPlayingCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: NowPlayingCollectionViewCell.identifier)
        
        
        collectionViewNowPlaying.dataSource = self
        collectionViewNowPlaying.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension NowPlayingTableViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.nowPlayMovieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingCollectionViewCell.identifier, for: indexPath) as? NowPlayingCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.mData = self.nowPlayMovieList[indexPath.row]
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}
extension NowPlayingTableViewCell : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UserDefaultUtil.shared.saveMovieId(movieId: self.nowPlayMovieList[indexPath.row].id)
        UserDefaultUtil.shared.saveMoviePoster(path: self.nowPlayMovieList[indexPath.row].posterPath)
        UserDefaultUtil.shared.saveMovieOverview(overview: self.nowPlayMovieList[indexPath.row].overview)
        UserDefaultUtil.shared.saveMovieIsAdult(isAdult: self.nowPlayMovieList[indexPath.row].adult)
        UserDefaultUtil.shared.saveMovieDate(date: self.nowPlayMovieList[indexPath.row].releaseDate)
        self.mDelegate.onTapMovie(id: self.nowPlayMovieList[indexPath.row].id)
    }
}
