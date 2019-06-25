//
//  ViewBindingProtocol.swift
//  MGXWeather
//
//  Created by Miu on 2019/4/25.
//  Copyright © 2019 MGX. All rights reserved.
//

import Foundation
protocol ViewBindingProtocol: class  {
    func attachView(view: ViewRenderingProtocol) -> Void
    func deAttachView() -> Void
}
