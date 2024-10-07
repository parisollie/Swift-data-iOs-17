//
//  Compras.swift
//  ComprasData
//
//  Created by Paul F on 07/10/24.
//

import SwiftUI
import SwiftData

struct ComprasView: View {
    //Vid 437.traer los dtaos de un modelo con bindable.
    @Bindable var itemList : ListModel
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    //Vid 438
    @State private var articulo = ""
    @State private var precio = ""
    @State private var cantidad = 1
    
    @FocusState private var isFocus : Bool
    //Vid 441
    @Query private var articulos : [ArticulosModel]
    /*
     //Vid 442,asi es como debería ser la consulta
    init(itemList: ListModel){
        self.itemList = itemList
        _articulos = Query(filter: #Predicate<ArticulosModel> { $0.idList.contains(itemList.id) } )
    }
    */
    
    //Vid 443
    var precioFinal : Float {
        articulos.filter { $0.idList.contains(itemList.id) }.reduce(0.0){ $0 + $1.precio }
    }
    
    var body: some View {
        //Vid 438
        VStack{
            VStack{
                TextField("Articulo", text: $articulo)
                    .textFieldStyle(.roundedBorder)
                    .focused($isFocus)
                HStack{
                    TextField("Precio", text: $precio)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 100)
                    Spacer()
                    //Vid 439
                    ContadorView(contador: $cantidad)
                }
                HStack{
                    Button {
                        //Vid 441
                        let precioTotal = (Float(precio) ?? 0) * Float(cantidad)
                        //Guardamos
                        let newArticulo = ArticulosModel(articulo: articulo, precio: precioTotal, idList: itemList.id)
                        //llamámos nuestro articulo
                        itemList.relationArticulos.append(newArticulo)
                        isFocus = true
                        articulo = ""
                        precio = ""
                        cantidad = 1
                        
                        //Vid 444, para editar
                        let updatePresupuesto = (Float(itemList.prespuesto) ?? 0 ) - precioTotal
                        
                        //Le damos a la variable una nuvo valor
                        itemList.prespuesto = String(updatePresupuesto)
                        
                    } label: {
                        Text("Agregar")
                    }
                    Spacer()
                    Text("Presupuesto: $\(itemList.prespuesto)").bold()

                }
                
            }.padding(.all)
            
            List{
                Section("Carrito"){
                    //Vid 441 //Vid 442 ,$0.idList.contains(itemList.id) }
                    ForEach(articulos.filter { $0.idList.contains(itemList.id) } ){ item in
                        //Vid 441
                        HStack{
                            Text(item.articulo)
                            Spacer()
                            //Vid 443
                            Text("$\(item.precio.formatted())")
                                .swipeActions {
                                    Button(role: .destructive) {
                                        //Vid 444,?? 0 le ponemos el valor por defecto.
                                        let sumaPre = (Float(itemList.prespuesto) ?? 0) + item.precio
                                        itemList.prespuesto = String(sumaPre)
                                        context.delete(item)
                                    } label: {
                                        Image(systemName: "trash")
                                    }

                                }
                        }
                    }
                    HStack{
                        //Vid 443
                        Text("Total:").bold()
                        Spacer()
                        Text("$\(precioFinal.formatted())").bold()
                    }
                }
            }
            
        }.navigationTitle(itemList.titulo)
            .navigationBarTitleDisplayMode(.inline)
        //Vid 444
            .toolbar{
                ToolbarItem{
                    Button {
                        //Cambiar el botón rojo.
                        itemList.completado = true
                        itemList.total = precioFinal
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                    }

                }
            }
    }
}

//Vid 439
struct ContadorView: View {
    @Binding var contador : Int
    var body: some View {
        HStack{
            Button {
                //para ir disminuyendo
                contador -= 1
                if contador <= 1{
                    //para no quedar en articulos negativos
                    contador = 1
                }
            } label: {
                Image(systemName: "minus")
            }
            Text("\(contador)")
            Button {
                contador += 1
            } label: {
                Image(systemName: "plus")
            }

        }
    }
}
