//
//  CreateValidatorSuccessMock.swift
//  iOSTakeHomeProjectTests
//
//  Created by Marcin Jędrzejak on 07/09/2022.
//

import Foundation
@testable import iOSTakeHomeProject

struct CreateValidatorSuccessMock: CreateValidatorImpl {
    
    func validate(_ person: iOSTakeHomeProject.NewPerson) throws {}
}
