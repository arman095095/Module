import UIKit

public protocol ModuleProtocol: AnyObject {
    var view: UIViewController { get }
    var inputObj: AnyObject? { get set }
    var outputObj: AnyObject? { get set }
    var transition: Transitioning? { get set }
}

public final class Module<Input: Any, Output: Any> {
    public var view: UIViewController
    
    public var input: Input? {
        set { _input = newValue as? AnyObject }
        get { _input as? Input }
    }
    
    public var output: Output? {
        set { _output = newValue as? AnyObject }
        get { _output as? Output  }
    }
    
    private weak var _input: AnyObject?
    private weak var _output: AnyObject? {
        didSet {
            completion?(output)
        }
    }
    
    public var transition: Transitioning?
    
    private let completion: ((Output?) -> ())?
    
    public init(input: Input?,
                view: UIViewController,
                completion: @escaping (Output?) -> ()) {
        self.view = view
        self.completion = completion
        self.input = input
    }
}

extension Module: ModuleProtocol {
    public var inputObj: AnyObject? {
        set { _input = newValue }
        get { _input }
    }
    
    public var outputObj: AnyObject? {
        set { _output = newValue }
        get { _output }
    }
}
