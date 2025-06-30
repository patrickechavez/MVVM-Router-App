//
//  ModalDestination.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 6/30/25.
//

import Foundation

enum ModalDestination: Identifiable, Hashable {
    case settings(theme: String)
    
    var id: Self { self }
}
