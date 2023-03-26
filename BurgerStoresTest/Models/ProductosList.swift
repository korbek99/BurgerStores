//
//  ProductosList.swift
//  BurgerStoresTest
//
//  Created by Jose David Bustos H on 26-03-23.
//

import Foundation
struct ProductosList: Decodable {
    let status: String
    let products: [Product]
}

// MARK: - Product
struct Product: Decodable {
    let id: String
    let name: String
    let desc: String
    let price: Int
    let image: String
    let page: String
    let latitude: String
    let longitude: String
}
