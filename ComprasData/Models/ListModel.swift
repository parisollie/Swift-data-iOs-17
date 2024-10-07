//
//  ListModel.swift
//  ComprasData
//
//  Created by Paul F on 07/10/24.
//

import Foundation
import SwiftData

//Viud 431 @ significa que es una macro ,es como si fuera nuestra tabla.
@Model
final class ListModel {
    //Vid 440
    @Attribute(.unique) var id : String
    var titulo : String
    var fecha : Date
    var completado : Bool
    var prespuesto : String
    var total : Float
    
    @Relationship(deleteRule: .cascade)
    var relationArticulos: [ArticulosModel]
    
    init(id: String = UUID().uuidString, titulo: String = "" , fecha: Date = .now, completado: Bool = false, prespuesto: String = "", total: Float = 0, relationArticulos: [ArticulosModel] = []) {
        self.id = id
        self.titulo = titulo
        self.fecha = fecha
        self.completado = completado
        self.prespuesto = prespuesto
        self.total = total
        //Vid 236 , lo agregamos para que no cause error
        self.relationArticulos = relationArticulos
    }
    
}
