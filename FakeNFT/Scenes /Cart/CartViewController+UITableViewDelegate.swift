//
//  CartViewController+UITableViewDelegate.swift
//  FakeNFT
//
//  Created by Vitaly on 09.10.2023.
//

import Foundation
import UIKit

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
    }
    
}
