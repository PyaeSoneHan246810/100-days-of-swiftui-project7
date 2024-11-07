import SwiftUI

struct AddSheetContentView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    @State private var type: String = "Personal"
    @State private var amount: Double = 0.0
    var types: [String] = ["Personal", "Business"]
    var expenses: Expenses
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $name)
                    TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.numberPad)
                    Picker("Type", selection: $type) {
                        ForEach(types, id: \.self) { type in
                            Text(type)
                        }
                    }.pickerStyle(.menu)
                }
                .listRowSeparator(.hidden)
            }
            .formStyle(.grouped)
            .listRowSpacing(12)
            .navigationTitle("Add Expense")
            .toolbar {
                Button("Save") {
                    let expenseItem = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(expenseItem)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddSheetContentView(expenses: Expenses())
}
