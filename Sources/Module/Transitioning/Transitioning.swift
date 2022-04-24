//
//  Transitioning.swift
//  
//
//  Created by Арман Чархчян on 09.04.2022.
//

import UIKit

public protocol Transitioning {
    var destination: UIViewController? { get } // should be weak
    func perform(_ completion: (()->())?) // present
    func reverse(_ completion: (()->())?) // dissmiss
}

public final class FullPresentTransition: Transitioning {
    public weak var source: UIViewController?
    public weak var destination: UIViewController?
    
    public init() { }
    
    public func perform(_ completion: (() -> ())?) {
        guard let destination = destination else { return }
        destination.modalPresentationStyle = .fullScreen
        source?.present(destination, animated: true, completion: completion)
    }
    
    public func reverse(_ completion: (() -> ())?) {
        destination?.dismiss(animated: true)
    }
}

public final class PresentTransition: Transitioning {
    public weak var source: UIViewController?
    public weak var destination: UIViewController?
    
    public init() { }
    
    public func perform(_ completion: (() -> ())?) {
        guard let destination = destination else { return }
        source?.present(destination, animated: true, completion: completion)
    }
    
    public func reverse(_ completion: (() -> ())?) {
        destination?.dismiss(animated: true)
    }
}

public final class PushTransition: Transitioning {
    public weak var source: UIViewController?
    public weak var destination: UIViewController?
    
    public init() { }
    
    public func perform(_ completion: (() -> ())?) {
        guard let destination = destination else { return }
        source?.navigationController?.pushViewController(destination, animated: true)
    }
    
    public func reverse(_ completion: (() -> ())?) {
        source?.navigationController?.popViewController(animated: true)
    }
}

extension UIViewController {
    
}
