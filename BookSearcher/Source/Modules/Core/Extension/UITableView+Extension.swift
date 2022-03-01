//
//  UITableView+Extension.swift
//  BookSearcher
//
//  Created by Arman Turalin on 01.03.2022.
//

import UIKit

extension UITableView {
    
    // MARK: - Methods
    func register(cellClass: AnyClass) {
        register(cellClass, forCellReuseIdentifier: "\(cellClass)")
    }
    
    func register(aClass: AnyClass) {
        register(aClass, forHeaderFooterViewReuseIdentifier: "\(aClass)")
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as? T else { fatalError(" table view cell identifier does not exist") }
        
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: "\(T.self)") as? T else { fatalError(" table view header footer view cell identifier does not exist") }
        
        return view
    }
}
