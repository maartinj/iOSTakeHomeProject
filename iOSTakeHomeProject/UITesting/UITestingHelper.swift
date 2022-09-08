//
//  UITestingHelper.swift
//  iOSTakeHomeProject
//
//  Created by Marcin Jędrzejak on 08/09/2022.
//

#if DEBUG

import Foundation

struct UITestingHelper {
    
    static var isUITesting: Bool {
        ProcessInfo.processInfo.arguments.contains("-ui-testing")
    }
    
    static var isNetworkingSuccessful: Bool {
        ProcessInfo.processInfo.environment["-networking-success"] == "1"
    }
    
}

#endif
