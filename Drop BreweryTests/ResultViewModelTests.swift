//
//  ResultViewModelTests.swift
//  Drop BreweryTests
//
//  Created by Conor Nolan on 29/07/2020.
//  Copyright © 2020 Conor Nolan. All rights reserved.
//

import Foundation
import XCTest

class ResultViewModelTests: XCTestCase {
    
    func testGivenInputStringThatShouldFail_WhenBrewery_ThenNoResultsShouldBeReturned() {
        // given
        let viewModel = ResultViewModel()
        let inputString = "1\n1 C\n 1 B"
        
        // when
        
        //then
        let returned = viewModel.brewery(inputString)

        
        XCTAssertNil(returned)
    }
    
    func testGivenInputStringThatShouldPass_WhenBrewery_ThenCorrectResultShouldBeReturned() {
        // given
        let viewModel = ResultViewModel()
        let inputString = "5\n2 B\n5 C\n1 C\n5 C 1 C 4 B\n3 C\n5 C\n3 C 5 C 1 C\n3 C\n2 B\n5 C 1 C\n2 B\n5 C\n4 B\n5 C 4 B"
        
        // when
        
        //then
        let returned = viewModel.brewery(inputString)
        let expected = ["C", "B", "C", "B", "C"]

        XCTAssertTrue(returned == expected)
    }
    
}
