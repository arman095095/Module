import UIKit

public protocol ModuleProtocol: AnyObject {
    var view: UIViewController { get }
    var input: AnyObject? { get }
    var output: AnyObject? { get set }
    var transition: Transitioning? { get set }
}

public final class Module<Input: Any, Output: Any> {
    public var view: UIViewController
    
    public var _input: Input? {
        set { inputObjc = newValue as? AnyObject }
        get { inputObjc as? Input }
    }
    
    public var _output: Output? {
        set { outputObjc = newValue as? AnyObject }
        get { outputObjc as? Output  }
    }
    
    private weak var inputObjc: AnyObject?
    private weak var outputObjc: AnyObject? {
        didSet {
            completion?(_output)
        }
    }
    
    public var transition: Transitioning?
    
    private let completion: ((Output?) -> ())?
    
    public init(input: Input?,
                view: UIViewController,
                completion: @escaping (Output?) -> ()) {
        self.view = view
        self.completion = completion
        self._input = input
    }
}

extension Module: ModuleProtocol {
    public var output: AnyObject? {
        get {
            outputObjc
        }
        set {
            outputObjc = newValue
        }
    }
    
    public var input: AnyObject? {
        get {
            inputObjc
        }
        set {
            inputObjc = newValue
        }
    }
}
