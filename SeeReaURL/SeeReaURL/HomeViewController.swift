//
//  HomeViewController.swift
//  SeeReaURL
//
//  Created by Seo Cindy on 11/11/23.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldStyle()
        
        let nib = UINib(nibName: RecentlyReportedTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: RecentlyReportedTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func segValueChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            typeLabel.text = "확인하고 싶은 링크를 입력하세요"
            textField.placeholder = "https://fake.com"
        case 1:
            typeLabel.text = "확인하고 싶은 계정 이름을 입력하세요"
            textField.placeholder = "blackpinkofficial"
        default:
            break
        }
    }
    
    
    func setTextFieldStyle() {
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor(named: "pointColor")?.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1.0
    }
    
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        if textField.text != nil {
            print("\(textField.text!)")
        }
        
        // 페이지 전환
        // 유효한 링크인 경우
        guard let qualifiedResultVC = self.storyboard?.instantiateViewController(withIdentifier: "QualifiedResultVC") as? QualifiedResultViewController else {return}
        self.navigationController?.pushViewController(qualifiedResultVC, animated: true)
            
        // 유효하지 않은 링크인 경우
//            guard let socialLoginVC = self.storyboard?.instantiateViewController(withIdentifier: “SocialLoginVC”) as? SocialLoginViewController else {return}
//            self.navigationController?.pushViewController(socialLoginVC, animated: true)
        
    }
    
}

extension HomeViewController: UITableViewDelegate {
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentlyReportedTableViewCell.identifier, for: indexPath) as? RecentlyReportedTableViewCell else { return UITableViewCell() }
        cell.setData(RecentlyReportedDataModel.sampleData[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecentlyReportedDataModel.sampleData.count
    }
}
