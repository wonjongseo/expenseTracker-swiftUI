//
//  TransactionListViewModel.swift
//  ExpenseTracker
//
//  Created by Jongseo Won on 5/25/25.
//

import Foundation
import Combine

typealias TransactionGroup = Dictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]

final class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
        
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getTransaction()
    }
    
    func getTransaction() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error) :
                    print("Error fetching transactions:" , error.localizedDescription)
                case .finished:
                    print("Finished fetching transactions")
                }
            } receiveValue: { [weak self] result in
                self?.transactions = result
            }
            .store(in: &cancellables)
    }
    
    func groupTransactionsByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else { return [:] }
        
        let groupedTransactions = TransactionGroup(grouping: transactions) { $0.month }
        
        return groupedTransactions
    }
    
    
    func accumulateTrnasaction() -> TransactionPrefixSum {
        guard !transactions.isEmpty else { return [] }
             
        let today = "02/17/2022".dateParsed()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        
        print("dateInterval ", dateInterval)
        
        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) {
            let dailyExpense = transactions.filter { $0.dateParsed == date && $0.isExpense }
            let dailyTotal = dailyExpense.reduce(0) { $0 - $1.signedAmount}
            
            sum += dailyTotal
            sum = sum.roundedTo2Digits()
            cumulativeSum.append((date.formatted(), sum))
        }
        return cumulativeSum
        
    }
}
