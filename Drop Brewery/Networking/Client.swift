//
//  Client.swift
//  Drop Brewery
//
//  Created by Conor Nolan on 29/07/2020.
//  Copyright © 2020 Conor Nolan. All rights reserved.
//

import Foundation
import Alamofire

class Client {
    static func beers(id: Int, completion:@escaping (Result<BeersResponse,AFError>)->Void) {
        AF.request(Router.beers(["per_page" : "\(id)"])
        ).responseDecodable(of: BeersResponse.self) { response in
            completion(response.result)
        }
    }
}
