//
//  CauseTableViewCell.swift
//  SeeReaURL
//
//  Created by Seo Cindy on 11/12/23.
//

import UIKit

struct CauseDataModel{
    let symbolImageName: String
    var symbolImage: UIImage? {
        return UIImage(named: symbolImageName)
    }
    let causeTitle: String
}

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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Cell 간격 조정
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 6, bottom: 10, right: 6))
      }
    
    func setData(_ causeData: CauseDataModel){
        symbolImg.image = causeData.symbolImage
        textInfo.text = causeData.causeTitle
    }
    
}

extension CauseDataModel{
    static let sampleData: [CauseDataModel] = [
        CauseDataModel(symbolImageName: "exclamationmark.shield.fill", causeTitle: "실제 링크를 숨겼습니다"),
        CauseDataModel(symbolImageName: "message.fill", causeTitle: "공식 카카오 오픈채팅방 링크가 아닙니다"),
        CauseDataModel(symbolImageName: "light.beacon.min.fill", causeTitle: "위험신고가 누적된 링크입니다")
    ]
}
