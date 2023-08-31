//
//  RecordTableViewCell.swift
//  DepremHasarTespit
//
//  Created by yunus oktay on 21.06.2023.
//

import UIKit

class RecordTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    var viewModel = RecordViewViewModel()
    var imageDataArray: [Data] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 10
            layout.itemSize = CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
            
            collectionView.collectionViewLayout = layout
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "CollectionViewCell", bundle: Bundle(for: CollectionViewCell.self)), forCellWithReuseIdentifier: "CollectionViewCell")
            imageDataArray = viewModel.imageDataArray
            collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)as! CollectionViewCell
        
        if indexPath.row < imageDataArray.count {
            if let image = UIImage(data: imageDataArray[indexPath.row] ) {
                    cell.imageView.image = image
                }
            }
        return cell
    }
    
}
