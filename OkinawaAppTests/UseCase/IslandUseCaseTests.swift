//
//  IslandUseCaseTests.swift
//  OkinawaAppTests
//
//  Created by nancy on 2019/10/27.
//  Copyright © 2019 nwatabou. All rights reserved.
//

import XCTest
@testable import OkinawaApp
import RxSwift

class IslandUseCaseTests: XCTestCase {

    private let useCase = IslandUseCase()
    private let disposeBag = DisposeBag()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchIslands() {
        let expectation = self.expectation(description: "Fetch islands info success patttern")

        useCase.fetchIslands().subscribe(onSuccess: { response in
            XCTAssertFalse(response.islands.isEmpty)
            guard let first = response.islands.first else {
                XCTFail("先頭が空っぽ")
                expectation.fulfill()
                return
            }
            XCTAssertEqual(first.id, "267")
            XCTAssertEqual(first.name, "瀬底島")
            XCTAssertEqual(first.nameKana, "セソコジマ")
            XCTAssertEqual(first.uri, URL(string: "http://ja.dbpedia.org/resource/瀬底島"))
            XCTAssertEqual(first.latitude, 26.6444555)
            XCTAssertEqual(first.longitude, 127.8620867)

            expectation.fulfill()
        }, onError: { error in
            XCTFail("島の情報の読み込みに失敗")
            expectation.fulfill()
        }).disposed(by: disposeBag)

        waitForExpectations(timeout: 5, handler: nil)
    }
}
