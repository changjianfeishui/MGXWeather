//
//  File.swift
//  MGXWeather
//
//  Created by Miu on 2019/4/25.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit
extension UIView {
    struct PresenterAssociatedKey {
        static var key = "presenterAssociatedKey"
    }
    var presenter:ViewBindingProtocol? {
        get {
            return objc_getAssociatedObject(self, &PresenterAssociatedKey.key) as? ViewBindingProtocol
        }
        set {
            objc_setAssociatedObject(self, &PresenterAssociatedKey.key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension UIViewController {
    struct PresenterAssociatedKey {
        static var key = "presenterAssociatedKey"
    }
    var presenter:ViewBindingProtocol {
        get {
            return objc_getAssociatedObject(self, &PresenterAssociatedKey.key) as! ViewBindingProtocol
        }
        
        set {
            objc_setAssociatedObject(self, &PresenterAssociatedKey.key, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
}
