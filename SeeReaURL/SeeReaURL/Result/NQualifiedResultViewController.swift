//
//  NQualifiedResultViewController.swift
//  SeeReaURL
//
//  Created by Seo Cindy on 11/11/23.
//

import UIKit

class NQualifiedResultViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // table cell 등록
        let nib = UINib(nibName: CauseTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CauseTableViewCell.identifier)
    }
    
    // 결과 제목
    
    // 링크 보여주기
    
    // 신고하기 -> 액션시트
    
    // 위험 요소 확인하기 -> 테이블 뷰

}
