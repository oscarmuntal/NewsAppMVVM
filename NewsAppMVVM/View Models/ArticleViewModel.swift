//
//  ArticleViewModel.swift
//  NewsAppMVVM
//
//  Created by Òscar Muntal on 9/3/23.
//

import Foundation
import RxSwift
import RxCocoa

struct ArticleListViewModel {
    let articles: [ArticleViewModel]
}

extension ArticleListViewModel {
    init(_ articles: [Article]) {
        self.articles = articles.compactMap(ArticleViewModel.init)
    }
}

extension ArticleListViewModel {
    func articleAt(_ index: Int) -> ArticleViewModel {
        articles[index]
    }
}

struct ArticleViewModel {
    let article: Article
    
    init(_ article: Article) {
        self.article = article
    }
}

extension ArticleViewModel {
    var title: Observable<String> {
        Observable<String>.just(article.title)
    }
    
    var description: Observable<String> {
        Observable<String>.just(article.description ?? "")
    }
}
