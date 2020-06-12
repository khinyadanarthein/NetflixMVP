//
//  SearchMovieCollectionViewCell.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 03/06/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit

class SearchMovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ivMovie: UIImageView!
    
     static var identifier : String {
         return "SearchMovieCollectionViewCell"
     }
     
     override func awakeFromNib() {
         super.awakeFromNib()
         // Initialization code
     }
     
     var mData:SearchMovieVO? = nil {
         didSet{
             if let data = mData{
                 self.bindData(data: data)
             }
         }
     }
     
     fileprivate func bindData(data:SearchMovieVO){
         
         let imageURL = IMAGE_URL_PATH + (data.posterPath ?? "")
         let url = URL(string: imageURL)
         ivMovie.kf.indicatorType = .activity
         ivMovie.kf.setImage(
             with: url,
             placeholder: UIImage(named: "logo"),
             options: [
                 .scaleFactor(UIScreen.main.scale),
                 .transition(.flipFromLeft(1)),
                 .cacheOriginalImage
             ])
         {
             result in
             switch result {
             case .success(let value):
                 _ = value.source.url
                 //print("Task done for: \(value.source.url?.absoluteString ?? "")")
             case .failure(let error):
                 print("Top rated Job failed: \(error.localizedDescription)")
             }
         }
     }

}
