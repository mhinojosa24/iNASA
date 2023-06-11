//
//  BaseVM.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/11/23.
//

import Foundation


class BaseVM {
    private(set) var service: Service?
    
    init(service: Service = ApiService()) {
        self.service = service
    }
}
