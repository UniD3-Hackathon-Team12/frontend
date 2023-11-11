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
    
    @IBAction func ShowActionSheetClick(_ sender: Any) {
        let actionSheet = UIAlertController(title: "신고하기", message: "구체적인 신고사유를 선택해주세요", preferredStyle: .actionSheet)
            
            //블로그 방문하기 버튼 - 스타일(default)
            actionSheet.addAction(UIAlertAction(title: "사칭 계정이에요", style: .default, handler: {(ACTION:UIAlertAction) in
                print("사칭 계정 신고")
            }))
        
            actionSheet.addAction(UIAlertAction(title: "거짓 링크에요", style: .default, handler: {(ACTION:UIAlertAction) in
                print("거짓 링크 신고")
            }))
        
            actionSheet.addAction(UIAlertAction(title: "사기 당한 적이 있는 계정/링크에요", style: .default, handler: {(ACTION:UIAlertAction) in
                print("사기 당한 적이 있는 계정/링크 신고")
            }))
            
            actionSheet.addAction(UIAlertAction(title: "기타 사유", style: .default, handler: {(ACTION:UIAlertAction) in
                print("기타 사유신고")
            }))
            
            //취소 버튼 - 스타일(cancel)
            actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
            
            self.present(actionSheet, animated: true, completion: nil)
    }

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
