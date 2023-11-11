//
//  QualifiedResultViewController.swift
//  SeeReaURL
//
//  Created by Seo Cindy on 11/11/23.
//

import UIKit

class QualifiedResultViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var linkview: UIView!
    @IBOutlet weak var copyBtn: UIButton!
    @IBOutlet weak var linkURL: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        addContentScrollView()
        setPageControl()

        self.linkview.layer.cornerRadius = 10
        self.scrollView.layer.cornerRadius = 10
        
        // 링크 보여주기
        linkURL.text = "주소 변수"
        
        
    }

    // 결과 제목
    
    // Remember! 경고 문구
    
    
    // 버튼1 : 링크 이동
    
    @IBAction func redirectLink(_ sender: Any) {
        if let url = URL(string: "https://www.naver.com/") {
                    UIApplication.shared.open(url, options: [:])
                }
    }
    
    // 버튼2 : 링크 복사
    
    @IBAction func copyLink(_ sender: Any) {
        UIPasteboard.general.string = "https://www.naver.com/"
        if let storedString = UIPasteboard.general.string {
                    print(storedString)
                }
        
        
        
    }
    // Tip! 문구
    
    // 사례 화면 구현 : 스크롤 뷰
    var images = [#imageLiteral(resourceName: "ex3"), #imageLiteral(resourceName: "ex2"), #imageLiteral(resourceName: "ex4"), #imageLiteral(resourceName: "ex5"), #imageLiteral(resourceName: "ex3")]
    var imageViews = [UIImageView]()
    
    private func addContentScrollView() {
            
            for i in 0..<images.count {
                let imageView = UIImageView()
                let xPos = scrollView.frame.width * CGFloat(i)
                imageView.frame = CGRect(x: xPos, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
                imageView.image = images[i]
                scrollView.addSubview(imageView)
                scrollView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
            }
            
        }
    private func setPageControl() {
            pageControl.numberOfPages = images.count
            
        }
        
        private func setPageControlSelectedPage(currentPage:Int) {
            pageControl.currentPage = currentPage
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let value = scrollView.contentOffset.x/scrollView.frame.size.width
            setPageControlSelectedPage(currentPage: Int(round(value)))
        }

    
}
