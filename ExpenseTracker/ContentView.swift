//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Jongseo Won on 5/25/25.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    
    @EnvironmentObject var transactionListVM : TransactionListViewModel
     
    var body: some View {
        NavigationView  {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Overview")
                        .font(.title2)
                        .bold()
                        
                    let data = transactionListVM.accumulateTrnasaction()
                    
                    if !data.isEmpty {
                        let totalExpenses = data.last?.1 ?? 0
                        CardView {
                            VStack(alignment: .leading) {
                                ChartLabel(totalExpenses.formatted(.currency(code: "USD")), type: .title, format: "$%.02f")
                                           LineChart()
                            }.background(Color.systemBackground)
                            
                        }.data(data)
                         .chartStyle(ChartStyle(
                            backgroundColor: Color.systemBackground,
                            foregroundColor: ColorGradient(Color.icon.opacity(0.4), Color.icon)))
                        .frame(height: 300)
                            
                    }
                    
                    RecentTransactionList()
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon, .primary)
                }
              
                
            }
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }
}


struct Content_Previews : PreviewProvider {
    
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions.append(transactionPreviewData)
        return transactionListVM
    }()
    
    static var previews: some View {
        ContentView()
//            .preferredColorScheme(.dark)
            .environmentObject(transactionListVM)
    }
}

