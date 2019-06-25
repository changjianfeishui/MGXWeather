//
//  File.swift
//  MGXWeather
//
//  Created by Miu on 2019/4/25.
//  Copyright © 2019 MGX. All rights reserved.
//

import Foundation
@objc protocol ViewRenderingProtocol:class {
    @objc optional func renderingView(viewModel:Any) -> Void
    @objc optional func eraseView() -> Void
    func buildPresenter() -> Void
}
