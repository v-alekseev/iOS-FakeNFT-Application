import Foundation

protocol ProfileViewModelProtocol: AnyObject {

    var profileObservable: ProfileObservable<Profile?> { get }
    var showErrorAlert: ((String) -> Void)? { get set }
    func changeProfile(profile: Profile)
    func fetchProfile()
}
