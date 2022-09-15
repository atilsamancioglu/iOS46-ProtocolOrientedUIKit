//
//  ProtocolOrientedUIKitTests.swift
//  ProtocolOrientedUIKitTests
//
//  Created by Atil Samancioglu on 15.09.2022.
//

import XCTest
@testable import ProtocolOrientedUIKit

final class ProtocolOrientedUIKitTests: XCTestCase {
    
    private var sut : UserViewModel! //system under test
    private var userService : MockUserService!
    private var output : MockUserViewModelOutput!

    override func setUpWithError() throws {
        userService = MockUserService()
        sut = UserViewModel(userService: userService)
        output = MockUserViewModelOutput()
        sut.output = output //every time viewmodel outputs to something we will catch it in our mock output
        //try super.setUpWithError() // optional
    }

    override func tearDownWithError() throws {
        sut = nil
        userService = nil
        //try super.tearDownWithError()
    }

    func testUpdateView_whenAPISuccess_showsEmailNameUserName() throws {
        //given
        let mockUser = User(id: 1, name: "Atil", username: "atilsamancioglu", email: "atil@gmail.com", address: Address(street: "", suite: "", city: "", zipcode: "", geo: Geo(lat: "", lng: "")), phone: "", website: "", company: Company(name: "", catchPhrase: "", bs: ""))
        userService.fetchUserMockResult = .success(mockUser)
        //when
        sut.fetchUsers()
        //then
        XCTAssertEqual(output.updateViewArray.count, 1)
        XCTAssertEqual(output.updateViewArray.first?.userName, "atilsamancioglu")

        
    }
    
    func testUpdateView_whenAPIFailure_showsNoUserFound() throws {
        
        //given
        userService.fetchUserMockResult = .failure(NSError())
        //when
        sut.fetchUsers()
        //then
        XCTAssertEqual(output.updateViewArray.count, 1)
        XCTAssertEqual(output.updateViewArray.first?.name, "No user")


    }


}

class MockUserService: UserService {
    var fetchUserMockResult : Result<ProtocolOrientedUIKit.User, Error>?
    func fetchUser(completion: @escaping (Result<ProtocolOrientedUIKit.User, Error>) -> Void) {
        if let result = fetchUserMockResult {
            completion(result)
        }
    }
}

class MockUserViewModelOutput : UserViewModelOutput {
    var updateViewArray : [(name:String, email:String, userName:String)] = []
    func updateView(name: String, email: String, userName: String) {
        updateViewArray.append((name,email,userName))
    }
    
    
}
