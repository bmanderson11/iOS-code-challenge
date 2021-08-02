//
//  DetailViewController.swift
//  ios-code-challenge
//
//  Created by Joe Rocca on 5/31/19.
//  Copyright © 2019 Dustin Lange. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    @IBOutlet weak var restRatingImageView: UIImageView!
    @IBOutlet weak var restImageView: UIImageView!
    @IBOutlet weak var restPriceTV: UILabel!
    @IBOutlet weak var restCatTV: UILabel!
    @IBOutlet weak var restTotalReviewsTV: UILabel!
    
    
    
    lazy private var favoriteBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Star-Outline"), style: .plain, target: self, action: #selector(onFavoriteBarButtonSelected(_:)))

    @objc var detailItem: YLPBusiness?
    
    private var _favorite: Bool = false
    private var isFavorite: Bool {
        get {
            return _favorite
        } 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        navigationItem.rightBarButtonItems = [favoriteBarButtonItem]
    }
    
    private func configureView() {
        guard let detailItem = detailItem else { return }
        detailDescriptionLabel.text = detailItem.name
        restCatTV.text = detailItem.category
        restPriceTV.text = detailItem.price
        restTotalReviewsTV.text = detailItem.totalreviews
        
        switch detailItem.rating {
        case "1":
            restRatingImageView.image = UIImage(named: "1")!
        case "1.5":
            restRatingImageView.image = UIImage(named: "1.5")!
        case "2":
            restRatingImageView.image = UIImage(named: "2")!
        case "2.5":
            restRatingImageView.image = UIImage(named: "2.5")!
        case "3":
            restRatingImageView.image = UIImage(named: "3")!
        case "3.5":
            restRatingImageView.image = UIImage(named: "3.5")!
        case "4":
            restRatingImageView.image = UIImage(named: "4")!
        case "4.5":
            restRatingImageView.image = UIImage(named: "4.5")!
        case "5":
            restRatingImageView.image = UIImage(named: "5")!
        default:
            restRatingImageView.image = UIImage(named: "Untitled-2")!
        }
        restImageView.downloaded(from: detailItem.thumbnail)
        
        updateFavoriteBarButtonState()
    }
    
  
    func setDetailItem(newDetailItem: YLPBusiness) {
        guard detailItem != newDetailItem else {
            return
            
        }
        detailItem = newDetailItem
       // configureView()
    }
    
    private func updateFavoriteBarButtonState() {
        if(detailItem != nil){
            favoriteBarButtonItem.image = detailItem!.isFavorite ? UIImage(named: "Star-Filled") : UIImage(named: "Star-Outline")
        }
        
    }
    
    @objc private func onFavoriteBarButtonSelected(_ sender: Any) {
        if(detailItem != nil){
            detailItem?.isFavorite.toggle()
        updateFavoriteBarButtonState()
        }
    }
}
