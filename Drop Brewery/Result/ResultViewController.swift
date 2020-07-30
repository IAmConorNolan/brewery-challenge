//
//  ViewController.swift
//  Drop Brewery
//
//  Created by Conor Nolan on 29/07/2020.
//  Copyright © 2020 Conor Nolan. All rights reserved.
//

import UIKit

protocol ResultViewControllerDelegate: class {
    var beer: BeersResponseElement? { get set }
}

class ResultViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel = ResultViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupTableView()
        viewModel.getBeer(for: 10)
    }
    
    func setupTableView() {
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        tableView.register(UINib(nibName: "BeerTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: K.Results.cellReuseIdentifier)
    }
    
    private weak var delegate: ResultViewControllerDelegate?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "resultsToDetails") {
            self.delegate = segue.destination as? ResultViewControllerDelegate
        }
    }
    
}

// MARK: UITableViewControllerDelegate

extension ResultViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "resultsToDetails", sender: self)
        delegate?.beer = viewModel.brewery[indexPath.row]
    }
    
}

// MARK: UITableViewControllerDataSource

extension ResultViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.brewery.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Results.cellReuseIdentifier) as! BeerTableViewCell
        
        let beerForCell = viewModel.brewery[indexPath.row]
        cell.configureCell(with: beerForCell)
        
        return cell
    }
    
}

// MARK: ResultViewModelDelegate

extension ResultViewController: ResultViewModelDelegate {
    func reloadTable() {
        self.tableView.reloadData()
    }
}
