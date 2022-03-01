//
//  AssembledScreen.swift
//  BookSearcher
//
//  Created by Arman Turalin on 01.03.2022.
//

import UIKit

class AssembledScreen<TModuleInput> {
    let input: TModuleInput
    let viewController: UIViewController
    
    init(input: TModuleInput, viewController: UIViewController) {
        self.input = input
        self.viewController = viewController
    }
}
