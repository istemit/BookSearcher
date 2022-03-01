//
//  BaseTarget.swift
//  SupermomsClub
//
//  Created by Arman Turalin on 01.03.2022.
//

import Foundation

protocol BaseTarget {
    var path: String { get }
    var method: HttpMethod { get }
}
