//
//  HeapsAlgorithim.swift
//  Drop Brewery
//
//  Created by Conor Nolan on 30/07/2020.
//  Copyright © 2020 Conor Nolan. All rights reserved.
//

import Foundation


struct HeapsAlgorithim {
    func heapPermutation<T>(data: inout Array<T>, output: (Array<T>) -> Void) {
        generate(n: data.count, data: &data, output: output)
    }

    func generate<T>(n: Int, data: inout Array<T>, output: (Array<T>) -> Void) {
        if n == 1 {
            output(data)
        } else {
            for i in 0 ..< n {
                generate(n: n - 1, data: &data, output: output)
                if n % 2 == 0 {
                    data.swapAt(i, n - 1)
                } else {
                    data.swapAt(0, n - 1)
                }
            }
        }
    }
}
