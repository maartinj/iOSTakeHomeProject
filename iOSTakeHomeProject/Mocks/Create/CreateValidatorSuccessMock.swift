//
//  CreateValidatorSuccessMock.swift
//  iOSTakeHomeProjectTests
//
//  Created by Marcin Jędrzejak on 07/09/2022.
//
#if DEBUG
import Foundation

struct CreateValidatorSuccessMock: CreateValidatorImpl {
    
    func validate(_ person: iOSTakeHomeProject.NewPerson) throws {}
}
#endif
