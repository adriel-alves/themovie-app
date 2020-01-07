//
//  DefaultsManager.swift
//  theMovie-app
//
//  Created by Adriel Alves on 06/01/20.
//  Copyright © 2020 adriel. All rights reserved.
//

import Foundation

class DefaultsManager {
    
    let defaults = UserDefaults.standard
    static var shared: DefaultsManager = DefaultsManager()
    
    
    private init() {
        
    }
}
