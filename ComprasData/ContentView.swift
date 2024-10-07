//
//  ContentView.swift
//  ComprasData
//
//  Created by Paul F on 07/10/24.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    
    //Vid 433 query en siwft data , traemos todo los datos que tengas en este modelo.
    //@Query private var items: [ListModel]
    //Vid 434
    //@Query (sort: \ListModel.titulo, order: .forward) private var items: [ListModel]
    //Vid 445
    @Query (filter: #Predicate<ListModel> { $0.completado == false }, sort: \ListModel.titulo, order: .forward) private var items: [ListModel]
    
    @Query (filter: #Predicate<ListModel> { $0.completado == true }, sort: \ListModel.titulo, order: .forward) private var itemsComplete: [ListModel]
    
    
    //Vid 436,para eliminar 
    @Environment(\.modelContext) var context
    @State private var show = false
    var body: some View {
        NavigationStack{
            List{
                Section("Activos"){
                    ForEach(items){ item in
                        //Vid 436
                        NavigationLink(value: item) {
                            CardView(item: item)
                                .swipeActions{
                                    Button (role: .destructive) {
                                        withAnimation{
                                            context.delete(item)
                                        }
                                    } label: {
                                        Image(systemName: "trash")
                                    }

                                }
                        }
                    }
                }
                Section("Completadas"){
                    //Vid 445 
                    ForEach(itemsComplete){ item in
                        //Vid 435, card para nuestra lista
                            CardComplete(item: item)
                            .swipeActions{
                                //Vid 436, eliminar
                                Button (role: .destructive) {
                                    withAnimation{
                                        context.delete(item)
                                    }
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                    }
                }
            }
            .navigationTitle("Mis Compras")
            .toolbar{
                ToolbarItem{
                    Button {
                        show.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
            .sheet(isPresented: $show, content: {
                NavigationStack{
                    AddView()
                    //para que se vea a la mitad la pantalla
                }.presentationDetents([.medium])
            })
            //Vid 436
            .navigationDestination(for: ListModel.self) {
                ComprasView(itemList: $0)
            }
        }
    }
}

//Vid 435
struct CardView: View {
    var item : ListModel
    var body: some View {
        HStack{
            Circle()
            //antes era foregroundColor
                .foregroundStyle(item.completado ? .green : .red )
                .frame(width: 10, height: 10)
            VStack(alignment: .leading){
                Text(item.titulo)
                    .bold()
                Text("\(item.fecha, format: Date.FormatStyle(date: .numeric, time: .shortened) )")
                    .font(.callout)
                    .foregroundStyle(.gray)
            }
        }
    }
}

//Vid 445, cuando se completan las compras.
struct CardComplete: View {
    var item : ListModel
    var body: some View {
        HStack{
            Circle()
                .foregroundStyle(.green)
                .frame(width: 10, height: 10)
            VStack(alignment: .leading){
                Text(item.titulo)
                    .bold()
                Text("Resto: $\(item.prespuesto) Total Compra: $\(item.total.formatted())")
                    .font(.callout)
                    .foregroundStyle(.gray)
            }
        }
    }
}



