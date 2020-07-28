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
            
            commonView.leadingAnchor.constraint(equalTo: leadingAnchor),
            commonView.topAnchor.constraint(equalTo: topAnchor),
            commonView.bottomAnchor.constraint(equalTo: bottomAnchor),
            commonView.widthAnchor.constraint(equalTo: heightAnchor),
            ])
    }

    static var identifier : String {
        return "CustomSearchCollectionViewCell"
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
