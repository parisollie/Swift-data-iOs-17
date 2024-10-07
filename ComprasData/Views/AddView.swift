//
//  AddView.swift
//  ComprasData
//
//  Created by Paul F on 07/10/24.
//

import SwiftUI
import SwiftData
struct AddView: View {
    
    //Vid 432
    @State private var item = ListModel()
    @Environment(\.modelContext) var context
    //Vid 433
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List{
            TextField("Titulo", text: $item.titulo)
            TextField("Presupuesto", text: $item.prespuesto)
                .keyboardType(.numberPad)
            DatePicker("Fecha", selection: $item.fecha)
            Button {
                //Guardar en swift data 
                withAnimation{
                    context.insert(item)
                }
                //Vid 433 
                dismiss()
            } label: {
                Text("Guardar")
            }
            .navigationTitle("Crear Compra")

        }
    }
}


