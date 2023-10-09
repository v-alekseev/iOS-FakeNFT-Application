//
//  CartViewController+UITableViewDataSource.swift
//  FakeNFT
//
//  Created by Vitaly on 09.10.2023.
//

import Foundation
import UIKit

extension CartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CartTableViewCell = self.cartTable.dequeueReusableCell()
        
        cell.setup(image: UIImage(resource: .nfTcard), name: "April", rank: indexPath.row + 2, price: "1,78 ETH")
        
        return cell
    }
}

