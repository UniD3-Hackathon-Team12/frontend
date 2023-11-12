//
//  RecentlyReportedTableViewCell.swift
//  SeeReaURL
//
//  Created by 김유미 on 11/12/23.
//

import UIKit

//struct RecentlyReportedDataModel {
//    let urlString: String
//}

protocol SendStringData{
    func sendData(mydata: [String])
}

class RecentlyReportedTableViewCell: UITableViewCell {
    static let identifier = "RecentlyReportedTableViewCell"
    
    var resourceData: [String] = []
    var delegate: SendStringData?
    let apiManager = DefaultAPIManager()
    
    @IBOutlet weak var url: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 10;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Cell 간격 조정
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 6, bottom: 5, right: 6))
      }
    
    
    func fetchHotURLs() {
        Task {
            do {
                let response = try await apiManager.getHotURLs()
//                for index in 0..<response.count {
//                    resourceData.append(RecentlyReportedDataModel(urlString: response[index]))
//                }
                delegate?.sendData(mydata: response)
                print("completedFetcg")
            } catch {
            }
        }
    }
    
    func setData(_ resourceURL: String){
        url.text = resourceURL
    }
}
