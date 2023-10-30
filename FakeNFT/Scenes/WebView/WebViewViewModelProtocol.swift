import Foundation

protocol WebViewViewModelProtocol: AnyObject {
    var currentProgressObserver: ProfileObservable<Float> { get }
    var isReadyToHideProgressViewObservable: ProfileObservable<Bool> { get }
    func setupProgres(newValue: Double)
}
