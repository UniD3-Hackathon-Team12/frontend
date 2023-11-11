//
//  RecentReportedTableViewCell.swift
//  SeeReaURL
//
//  Created by 김유미 on 11/12/23.
//

import UIKit

struct RecentReportedDataModel {
    let reportedUrl: String
}

class RecentReportedTableViewCell: UITableView {
    static let identifier = "RecentReportedTableViewCell"
    
    
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

extension RecentReportedDataModel {
    static let sampleData: [RecentReportedDataModel] = [
    RecentReportedDataModel(reportedUrl: "http://wnw.kr/jo"), RecentReportedDataModel(reportedUrl: "https://open-kakao.cam/qrt23"),
    RecentReportedDataModel(reportedUrl: "https://open-kakao.cam/sdvs1")]
}
