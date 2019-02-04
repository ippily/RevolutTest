//
//  NoDataStateViewModelTests.swift
//  RevolutCurrencyApplicationTests
//
//  Created by Emily Ip on 04/02/2019.
//  Copyright © 2019 Emily Ip. All rights reserved.
//

import XCTest
@testable import RevolutCurrencyApplication

class NoDataStateViewModelTest: XCTestCase {
    
    func testViewModel() {
        let title = "No data available, please try again."
        let image = "icon_delete_cloud"
        
        let mockViewModel = NoDataStateViewModel(title: title, image: image)
        XCTAssertEqual(mockViewModel.title, title)
        XCTAssertEqual(mockViewModel.image, image)
        
        let viewModel = NoDataStateViewModel.noDataAvailable
        XCTAssertEqual(viewModel.title, title)
        XCTAssertEqual(viewModel.image, image)
    }
}
