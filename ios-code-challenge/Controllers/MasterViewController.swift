//
//  MasterViewControllerS.swift
//  ios-code-challenge
//
//  Created by Joe Rocca on 5/31/19.
//  Copyright © 2019 Dustin Lange. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class MasterViewController: UITableViewController, CLLocationManagerDelegate, UITabBarDelegate, UISearchBarDelegate {
    
    var detailViewController: DetailViewController?
    let locationManager = CLLocationManager()
    var mBusinesses = [YLPBusiness]()
    var faveBusinesses = [YLPBusiness]()
    var filtered = [YLPBusiness]()
    var myLocation = CLLocation(latitude: 27.946733413762306, longitude: -82.53942334431218)
    var query = YLPSearchQuery()
    var isPaginating =  true;
    var atEnd = false;
    var offset = 0
    var showingFav = false
    @IBOutlet weak var restSearchBar: UISearchBar!
    
    
    
    lazy private var dataSource: NXTDataSource? = {
        guard let dataSource = NXTDataSource(objects: nil) else { return nil }
        dataSource.tableViewDidReceiveData = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.tableView.reloadData()
        }
        return dataSource
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        tableView.dataSource = dataSource
        tableView.delegate = self
       
    
        
        self.navigationItem.setLeftBarButton(UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action:  #selector(self.myLeftSideBarButtonItemTapped(_:))), animated: true)
        
    
        
        restSearchBar.delegate = self
        
     
    
       
        
        //updateSearch()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getFavorites()
        restSearchBar.text?.removeAll()
        showingFav = false
        dataSource?.setObjects(mBusinesses)
        tableView.reloadData()
    }
    
    func getFavorites(){
        faveBusinesses.removeAll()
        for i in 0..<mBusinesses.count{
            if mBusinesses[i].isFavorite {
                faveBusinesses.append(mBusinesses[i])
            }
        }
      
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        if(showingFav){
             filtered = faveBusinesses.filter { $0.name.contains(searchText) }
        }else{
             filtered = mBusinesses.filter { $0.name.contains(searchText) }
        }
       // let filtered = mBusinesses.filter { $0.name.contains(searchText) }
       
        if(!searchText.isEmpty){
        dataSource?.setObjects(filtered)
       
        }else{
            dataSource?.setObjects(mBusinesses)
        }
       
        getFavorites()
        tableView.reloadData()
        
    }
    

    

       @objc func myLeftSideBarButtonItemTapped(_ sender:UIBarButtonItem!)
       {
        restSearchBar.text?.removeAll()
        showingFav.toggle()
        if(showingFav){
        dataSource?.setObjects(faveBusinesses)
        tableView.reloadData()
          
        }
        else{
            dataSource?.setObjects(mBusinesses)
            tableView.reloadData()
        }
        
       }
    
    
    
    
    func updateSearch(){
        query = YLPSearchQuery(offset: myLocation, offset: UInt32(offset))
     
        if(showingFav || !restSearchBar.text!.isEmpty){
            return
        }
         AFYelpAPIClient.shared().search(with: query, completionHandler: { [weak self] (searchResult, error) in
             guard let strongSelf = self,
                 let dataSource = strongSelf.dataSource,
                 let businesses = searchResult?.businesses else {
                     return
             }
            if(businesses.count < 50){
                self!.atEnd = true
            }
            for i in 0..<businesses.count{
                businesses[i].location2 = self!.myLocation
                let distanceInMeters = self!.myLocation.distance(from: businesses[i].location)
                businesses[i].distance = distanceInMeters
            }
             self!.mBusinesses.append(contentsOf: businesses.sorted(by: { $0.distance < $1.distance }))
            self!.mBusinesses = self!.mBusinesses.sorted(by: { $0.distance < $1.distance })
            dataSource.setObjects(self!.mBusinesses)
            self!.getFavorites()
             strongSelf.tableView.reloadData()
            self!.isPaginating = false;
           
             
         })
         
        
        
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
     
        if position > tableView.contentSize.height - 20 - tableView.frame.size.height{
          
            if(!isPaginating){
            
            isPaginating = true
                if(offset + 50 < 1000) && !atEnd{
                    
                    offset += 50
                    updateSearch()
                }
            
            }else{
               return
            }
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController?.isCollapsed ?? false
        super.viewDidAppear(animated)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc = manager.location?.coordinate else { return }
        myLocation = CLLocation(latitude: loc.latitude, longitude: loc.longitude)
        //manager.stopUpdatingLocation()
        offset = 0
        mBusinesses.removeAll()
        tableView.setContentOffset(.zero, animated:true)
        updateSearch()
    }
     
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        DispatchQueue.main.async(){
           self.performSegue(withIdentifier: "showDetail", sender: self)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else {
                return
            }
            let nav = segue.destination as! UINavigationController
            let controller = nav.topViewController as! DetailViewController
            
            if(!restSearchBar.text!.isEmpty){
                
                let object = filtered[indexPath.row]
                controller.setDetailItem(newDetailItem: object)
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }else if showingFav{
                
                let object = faveBusinesses[indexPath.row]
                controller.setDetailItem(newDetailItem: object)
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }else{
                let object = mBusinesses[indexPath.row]
                controller.setDetailItem(newDetailItem: object)
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
           
        }
    }

}
