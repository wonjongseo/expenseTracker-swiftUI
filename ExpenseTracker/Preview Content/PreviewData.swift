//
//  PreviewData.swift
//  ExpenseTracker
//
//  Created by Jongseo Won on 5/25/25.
//

import Foundation

var transactionPreviewData = Transaction(id: 1, date: "01/24/2022", institution: "Desjardins", account: "Visa Desjardins", merchant: "Apple", amount: 11.49, type: "debit", categoryId: 801, category: "Software", isPending: false, isTransfer: false, isExpense: true, isEdited: false)



var transactionListData = [Transaction](repeating: transactionPreviewData, count: 10)
