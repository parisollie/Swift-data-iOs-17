//
//  ArticulosModel.swift
//  ComprasData
//
//  Created by Paul F on 07/10/24.
//


import Foundation
import SwiftData

//Vid 440
@Model
final class ArticulosModel{
    @Attribute(.unique) var articulo : String
    var precio : Float
    var idList : String
    
    //Vid 440
    @Relationship(inverse: \ListModel.relationArticulos)
    var relationList : ListModel?
    
    init(articulo: String, precio: Float, idList: String) {
        self.articulo = articulo
        self.precio = precio
        self.idList = idList
    }
}

