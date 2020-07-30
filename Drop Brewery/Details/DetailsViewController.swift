//
//  DetailsViewController.swift
//  Drop Brewery
//
//  Created by Conor Nolan on 30/07/2020.
//  Copyright © 2020 Conor Nolan. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, ResultViewControllerDelegate {

    @IBOutlet weak var beerImageView: BeerImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    internal var beer: BeersResponseElement? {
        didSet {
            self.hops = beer?.ingredients?.hops
            self.malts = beer?.ingredients?.malt
            self.methods = beer?.method
        }
    }
    
    var hops: [Hop]?
    var malts: [Malt]?
    var methods: Method?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configure()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configure() {
        nameLabel.text = beer?.name ?? "No name specified"
        abvLabel.text = "No abv specified."
           
        if let imageUrlString = beer?.imageURL, let imageUrl = URL(string: imageUrlString) {
            beerImageView.loadImage(from: imageUrl)
        }
           
        if let abv = beer?.abv {
            abvLabel.text = "\(abv)%"
        }
    }

}

// MARK: UITableViewControllerDelegate

extension DetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = UIColor.systemGroupedBackground
        
        switch section {
        case 0: label.text = "Hops"
        case 1: label.text = "Malts"
        case 2: label.text = "Method"
        default: label.text = "Beer"
        }
        return label
    }
    
}

// MARK: UITableViewControllerDataSource

extension DetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.hops?.count ?? 0
        case 1:
            return self.malts?.count ?? 0
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell")
        
        switch indexPath.section {
            case 0:
                cell?.textLabel?.text = self.hops?[indexPath.row].name
            case 1:
                cell?.textLabel?.text = self.malts?[indexPath.row].name
            case 2:
                cell?.textLabel?.text = self.methods?.twist
            default:
                break
        }
        
        return cell!
    }
    
}


