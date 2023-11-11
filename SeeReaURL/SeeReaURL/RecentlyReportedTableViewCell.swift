//
//  RecentlyReportedTableViewCell.swift
//  SeeReaURL
//
//  Created by 김유미 on 11/12/23.
//

import UIKit

struct RecentlyReportedDataModel {
    let title: String
}

class RecentlyReportedTableViewCell: UITableViewCell {
    static let identifier = "RecentlyReportedTableViewCell"
    
    @IBOutlet weak var url: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.layer.cornerRadius = 10;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Cell 간격 조정
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 6, bottom: 5, right: 6))
      }
    
    func setData(_ reportedDataModel: RecentlyReportedDataModel){
        url.text = reportedDataModel.title
    }
    
}

extension RecentlyReportedDataModel {
    static let sampleData: [RecentlyReportedDataModel] = [
        RecentlyReportedDataModel(title: "https://fake-url.com"),
    RecentlyReportedDataModel(title: "open-kakao.cam/saiof3"),
    RecentlyReportedDataModel(title: "xcvghth.cam/1fs")]
}
