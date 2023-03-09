//
//  Article.swift
//  NewsAppMVVM
//
//  Created by Òscar Muntal on 9/3/23.
//

import Foundation

struct ArticleResponse: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String?
}
