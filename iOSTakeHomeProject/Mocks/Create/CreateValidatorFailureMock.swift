//
//  CreateValidatorFailureMock.swift
//  iOSTakeHomeProjectTests
//
//  Created by Marcin Jędrzejak on 07/09/2022.
//
#if DEBUG
import Foundation

struct CreateValidatorFailureMock: CreateValidatorImpl {
    
    func validate(_ person: iOSTakeHomeProject.NewPerson) throws {
        throw CreateValidator.CreateValidatorError.invalidFirstName
    }
}
#endif
