//
//  NQualifiedResultViewController.swift
//  SeeReaURL
//
//  Created by Seo Cindy on 11/11/23.
//

import UIKit

class NQualifiedResultViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var box: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // table cell 등록
        let nib = UINib(nibName: CauseTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CauseTableViewCell.identifier)
        
        // 프로토콜 등록
        tableView.delegate = self
        tableView.dataSource = self
        
        box.layer.cornerRadius = 10
    }
    
    // 결과 제목
    
    // 링크 보여주기
    
    // 신고하기 -> 액션시트
    
    // 위험 요소 확인하기 -> 테이블 뷰
    

}

extension NQualifiedResultViewController: UITableViewDelegate{
    
}

extension NQualifiedResultViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CauseDataModel.sampleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CauseTableViewCell.identifier, for: indexPath) as? CauseTableViewCell else { return UITableViewCell() }
               
               cell.setData(CauseDataModel.sampleData[indexPath.row])
               
               return cell
    }
}
