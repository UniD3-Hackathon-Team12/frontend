//
//  CauseTableViewCell.swift
//  SeeReaURL
//
//  Created by Seo Cindy on 11/12/23.
//

import UIKit

class CauseTableViewCell: UITableViewCell {
    
    static let identifier = "CauseTableViewCell"
    
    
    @IBOutlet weak var textInfo: UILabel!
    @IBOutlet weak var symbolImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func setData(_ causeData: CauseDataModel){
//        symbolImg.image = causeData.symbolImage
//        textInfo.text = causeData.causeTitle
//    }
    
}
