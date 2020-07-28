//
//  CustomSearchCollectionViewCell.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 27/07/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit

class CustomSearchCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var commonView : CommonCellView = {
       let view = CommonCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func buildView() {
        
//        let imageView = CommonCellView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//
        self.contentView.addSubview(commonView)
        
        NSLayoutConstraint.activate([
            
            commonView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            commonView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            commonView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0),
            commonView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static var identifier : String {
        return "CustomSearchCollectionViewCell"
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
        commonView.backImageView.kf.indicatorType = .activity
        commonView.backImageView.kf.setImage(
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
