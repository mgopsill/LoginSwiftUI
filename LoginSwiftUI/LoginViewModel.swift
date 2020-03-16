//
//  LoginViewModel.swift
//  LoginSwiftUI
//
//  Created by Mike Gopsill on 16/03/2020.
//  Copyright © 2020 Ford. All rights reserved.
//

import Combine
import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var wizardName: String = ""
    @Published var password: String = ""
    @Published var passwordRepeat: String = ""
    
    @Published var buttonIsEnabled: Bool = false
    @Published var isFetching: Bool = false
    
    var subscriber: Cancellable?
    
    init() {
        let passwordIsValid = $password
            .combineLatest($passwordRepeat)
            .map {
                return $0 == $1 && $0.count > 6
        }
        
        let wizardNameIsValid = $wizardName
            .dropFirst()
            .map { [weak self] _ in
                self?.isFetching = true
                self?.buttonIsEnabled = false
        }
        .delay(for: .seconds(2.0), scheduler: RunLoop.main)
        .map { [weak self] _ in
                self?.isFetching = false
        }
        .map { _ in
            return Bool.random() }
        
        subscriber = passwordIsValid.combineLatest(wizardNameIsValid)
            .map {
                return $0 && $1
        }.assign(to: \.buttonIsEnabled, on: self)
    }
}
