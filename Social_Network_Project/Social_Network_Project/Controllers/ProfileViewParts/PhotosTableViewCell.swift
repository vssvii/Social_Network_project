//
//  PhotosTableViewCell.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 04.06.2022.
//

import UIKit
import SnapKit

public class PhotosTableViewCell: UITableViewCell  {
    
    let viewModel = PhotosViewModel()
    
    
    private enum CellReuseIdentifiers: String {
        case photos
        case collection
    }
    
    lazy var photosLabel: UILabel = {
        let photosLabel = UILabel()
        photosLabel.text = "Фотографии"
        photosLabel.font = UIFont.boldSystemFont(ofSize: 16)
        photosLabel.textColor = .black
        photosLabel.numberOfLines = 1
        return photosLabel
        }()
    
    lazy var photosCountLabel: UILabel = {
        let photosCountLabel = UILabel()
        photosCountLabel.font = UIFont.boldSystemFont(ofSize: 14)
        photosCountLabel.textColor = UIColor(hex: "#7E8183")
        photosCountLabel.text = "\(viewModel.photos.count)"
        return photosCountLabel
    }()
    
    lazy var rightPointerButton: UIButton = {
        let rightPointerButton = UIButton()
        rightPointerButton.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        rightPointerButton.tintColor = .black
        return rightPointerButton
    }()
    
    lazy var photosCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        let photosCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: viewLayout)
        photosCollectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: CellReuseIdentifiers.photos.rawValue)
        photosCollectionView.showsHorizontalScrollIndicator = false
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        return photosCollectionView
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    private func setupView() {
        
        
        contentView.addSubview(photosLabel)
        contentView.addSubview(photosCountLabel)
        contentView.addSubview(rightPointerButton)
        contentView.addSubview(photosCollectionView)
        
        
        
        photosLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(12)
            make.left.equalTo(contentView.snp.left).offset(12)
        }
        
        photosCountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(14)
            make.left.equalTo(photosLabel.snp.right).offset(6)
        }
        
        rightPointerButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(12)
            make.right.equalTo(contentView.snp.right).offset(-12)
        }
        
        photosCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(photosLabel.snp.bottom).offset(16)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
}

extension PhotosTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
        }
        
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photo = viewModel.photos[indexPath.item]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseIdentifiers.photos.rawValue, for: indexPath) as! PhotosCollectionViewCell
        cell.photoImageView.image = photo.image
        return cell
    }
        
        
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 72, height: 67)
    }
        
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                        return 50
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
        
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                        print(indexPath.row)
    }
 
}

//extension UITableViewCell {
//    open override func addSubview(_ view: UIView) {
//        super.addSubview(view)
//        sendSubviewToBack(contentView)
//    }
//}
