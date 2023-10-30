import UIKit

protocol MyNFTViewModelProtocol: AnyObject {

    var nftCardsObservable: ProfileObservable<NFTCards?> { get }
    var usersObservable: ProfileObservable<Users?> { get }
    var profileObservable: ProfileObservable<Profile?> { get }

    func fetchNtfCards(nftIds: [String])
    func sortNFTCollection(option: SortingOption)
    func changeProfile(likesIds: [String])
    var showErrorAlert: ((String) -> Void)? { get set }
}
