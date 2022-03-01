//
//  BasePresenter.swift
//  SupermomsClub
//
//  Created by Arman Turalin on 01.03.2022.
//

import Foundation

class BasePresenter {
    weak var baseViewController: BaseViewController?
    var baseInteractor: BaseInteractor
    var baseRouter: BaseRouter
    
    init(interactor: BaseInteractor?, router: BaseRouter?, viewController: BaseViewController? = nil) {
        self.baseInteractor = interactor ?? BaseInteractor()
        self.baseRouter = router ?? BaseRouter(viewController: viewController ?? BaseViewController())
        self.baseViewController = viewController
    }
}
