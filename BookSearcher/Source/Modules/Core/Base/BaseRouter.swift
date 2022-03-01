//
//  BaseRouter.swift
//  SupermomsClub
//
//  Created by Arman Turalin on 01.03.2022.
//

import UIKit

class BaseRouter {
    weak var viewController: UIViewController?
    weak var basePresenter: BasePresenter?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}
