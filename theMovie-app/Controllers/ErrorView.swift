//
//  ErrorView.swift
//  theMovie-app
//
//  Created by Adriel Alves on 13/01/20.
//  Copyright © 2020 adriel. All rights reserved.
//

import UIKit

enum ErrorType {
    case notFound(searchText: String),
    genericError
}

protocol ErrorViewDelegate {
    func errorViewAction()
}

class ErrorView: UIView {

    @IBOutlet weak var ivError: UIImageView!
    @IBOutlet weak var lbError: UILabel!
    
    var delegate: ErrorViewDelegate?
    
    
    
    func show(_ viewController: UIViewController, type: ErrorType,  delegate: ErrorViewDelegate) {
      
    }
    
}
