//
//  ResultViewModel.swift
//  Drop Brewery
//
//  Created by Conor Nolan on 29/07/2020.
//  Copyright © 2020 Conor Nolan. All rights reserved.
//

import Foundation

protocol ResultViewModelDelegate: class {
    func reloadTable()
}

class ResultViewModel {
    
    weak var delegate: ResultViewModelDelegate?
    
    var brewery = [BeersResponseElement]() {
        didSet {
            self.delegate?.reloadTable()
            print("Brewery has been updated, now contains \(brewery.count) beers.")
        }
    }
    
    func getBeer(for numberOfBeers: Int) {
        Client.beers(id: numberOfBeers) { (response) in
            switch response {
            case .success(let beer):
                self.brewery = beer
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

func processInput(_ input: String) -> (Int?, Array<Substring>) {
    let lines = input.split(separator: "\n")
    let numberOfBeerFlavours = Int(String(lines.first!))
    let customers = Array(lines.dropFirst())
    return (numberOfBeerFlavours, customers)
}

func brewery(_ input: String) -> Array<String>? {
    let lines = input.split(separator: "\n")
    
    guard let firstLine = lines.first, let numberOfBeerFlavours = Int(String(firstLine)) else {
        print("Error parsing numberOfBeerFlavours.")
        return nil
    }
    
    var beerDictionary = Dictionary<Int, String>(minimumCapacity: numberOfBeerFlavours)
    
    let customers = lines.dropFirst()
    
    let flatCustomers = customers.compactMap { $0 }
    
    print(flatCustomers)
    
    for customer in customers {
        let splitCustomer = customer.split(separator: " ")
        for num in 0..<splitCustomer.count/2 {
            let cursor = num * 2
            let type = String(splitCustomer[cursor+1])
            
            guard let flavour = Int(splitCustomer[cursor]) else {
                print("Error parsing flavour.")
                return nil
            }
            
            let existingType = beerDictionary[flavour]
            
            if (existingType == nil || type == existingType) {
                beerDictionary[flavour] = type
            } else {
                print("No solution exists")
                return nil
            }
        }
    }
    
    var results = [String]()
    
    for num in 1...numberOfBeerFlavours {
        results.append(beerDictionary[num]!)
    }
    
    print(String(describing: results))
    return results
}



