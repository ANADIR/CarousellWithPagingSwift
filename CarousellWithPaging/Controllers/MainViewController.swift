//
//  ViewController.swift
//  CarousellWithPaging
//
//  Created by עמית נדיר on 23/10/2019.
//  Copyright © 2019 AmitLTD. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let childVC : carousellViewController = carousellViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCarousellViewController()
    }
    
    func loadCarousellViewController(){
        self.addChild(childVC)
        
        // Add the child's View as a subview
        self.view.addSubview(childVC.view)
        
        //Adding the carousel ViewController to fit the VC width
        //Height will be set dynamically to fit the cell
        childVC.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: childVC.carousellCollectionView.frame.height * 1.1)
        
        childVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        //Update childviewcontroller it's contained in it's parent
        childVC.didMove(toParent: self)
    }
}

