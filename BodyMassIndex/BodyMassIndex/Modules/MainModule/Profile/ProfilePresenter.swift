//
//  ProfilePresenter.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation 

class ProfilePresenter {

    weak var view: ProfileView?

    fileprivate weak var router: ProfileRouter?

    init(view: ProfileView?, router: ProfileRouter?) {

        self.view = view

        self.router = router
    }
}

extension ProfilePresenter: ProfileEventHandler {
}
