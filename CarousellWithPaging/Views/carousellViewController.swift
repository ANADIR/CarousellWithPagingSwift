//
//  carousellViewController.swift
//  CarousellWithPaging
//
//  Created by עמית נדיר on 23/10/2019.
//  Copyright © 2019 AmitLTD. All rights reserved.
//

import UIKit

class carousellViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var carousellCollectionView: UICollectionView! {
        didSet {
            let nibName = UINib(nibName: cellIdentifier, bundle: nil)
            carousellCollectionView.register(nibName, forCellWithReuseIdentifier: cellIdentifier)
            
            carousellCollectionView.dataSource = self
            carousellCollectionView.delegate = self
        }
    }
    
    @IBOutlet private weak var collectionViewLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionViewLayout.minimumLineSpacing = CELL_SPACING
        }
    }
    
    //images aray - Can be edited outside this class to modify the images 
    var dataSource : [UIImage?] = [UIImage.init(named: "demoImg1"), UIImage.init(named: "demoImg2"), UIImage.init(named: "demoImg3"), UIImage.init(named: "demoImg4"), UIImage.init(named: "demoImg5")]
    let PLACEHOLDER_IMAGE_NAME = "placeholderImg"
    
    private var indexOfCellBeforeDragging = 0
    private let cellIdentifier = "carousellCollectionViewCell"
    
    //Consts we don't change
    private var CELL_SPACING : CGFloat = 10
    private var CAROUSELL_MARGIN : CGFloat = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureCollectionViewLayoutItemSize()
    }
    
    private func configureCollectionViewLayoutItemSize() {
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: CAROUSELL_MARGIN, bottom: 0, right: CAROUSELL_MARGIN)
        
        collectionViewLayout.itemSize = CGSize(width: collectionViewLayout.collectionView!.frame.size.width - CAROUSELL_MARGIN * 2, height: collectionViewLayout.collectionView!.frame.size.height)
    }
    
    private func indexOfFocuesedCell() -> Int {
        let itemWidth = collectionViewLayout.itemSize.width
        if itemWidth != 0 {
            let proportionalOffset = (collectionViewLayout.collectionView?.contentOffset.x ?? 0) / itemWidth
            let index = Int(round(proportionalOffset))
            let safeIndex = max(0, min(dataSource.count - 1, index))
            return safeIndex
        }
        return 0
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! carousellCollectionViewCell
        if let image = self.dataSource[indexPath.row] {
            cell.cellImageView.image = image
        } else {
            cell.cellImageView.image = UIImage.init(named: PLACEHOLDER_IMAGE_NAME)
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.indexOfCellBeforeDragging = indexOfFocuesedCell()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        // Stop scrollView sliding, to create paging effect
        targetContentOffset.pointee = scrollView.contentOffset
        
        // Check where scrollView should snap to
        let indexOfMajorCell = self.indexOfFocuesedCell()
        
        // Scroll
        let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
        collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
