import UIKit

protocol FavouriteNftsViewModelProtocol: AnyObject {
    
    var nftCardsObservable: ProfileObservable<NFTCards?> { get }
    var usersObservable: ProfileObservable<Users?> { get }
    var profileObservable: ProfileObservable<Profile?> { get }
    func fetchNtfCards(likes: [String])
    func changeProfile(likesIds: [String])
    var showErrorAlert: ((String) -> Void)? { get set }
}
