//
//  NewsTableViewController.swift
//  NewsAppMVVM
//
//  Created by Òscar Muntal on 9/3/23.
//

import UIKit
import RxSwift

class NewsTableViewController: UITableViewController {
    private let disposeBag = DisposeBag()
    private var articleListViewModel: ArticleListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        populateNews()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let articleListVM = articleListViewModel else { return 0 }
        return articleListVM.articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else { fatalError("ArticleTableViewCell not found") }
        
        guard let articleVM = articleListViewModel?.articleAt(indexPath.row) else { return cell }
        
        articleVM.title.asDriver(onErrorJustReturn: "")
            .drive(cell.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        articleVM.description.asDriver(onErrorJustReturn: "")
            .drive(cell.descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        return cell
    }
}

private extension NewsTableViewController {
    func populateNews() {
        let apiKey = "PRIVATE-API-KEY"
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)") else { fatalError("URL doesn't work") }
        let resource = Resource<ArticleResponse>(url: url)
        
        URLRequest.requestDecodable(resource: resource)
            .subscribe(onNext: { articleResponse in
                
                let articles = articleResponse.articles
                self.articleListViewModel = ArticleListViewModel(articles)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }).disposed(by: disposeBag)
    }
}
