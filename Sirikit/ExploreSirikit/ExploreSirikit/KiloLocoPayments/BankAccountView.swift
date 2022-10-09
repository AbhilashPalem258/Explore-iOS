//
//  ContentView.swift
//  ExploreSirikit
//
//  Created by Abhilash Palem on 28/09/22.
//

import SwiftUI
import Intents

class ContentViewModel: ObservableObject {
    @Published var bankBalance: Double = 0.0
    
    init() {
        if BankAccount.balance == nil {
            BankAccount.setDefaultAmount(amount: 1000)
        }
        self.bankBalance = 1000.0
    }
    
    func fetchBankBalance() {
        bankBalance = BankAccount.balance ?? 0.0
    }
}

struct BankAccountView: View {
    
    @StateObject private var vm = ContentViewModel()
        
    var body: some View {
        ZStack {
            RadialGradient(colors: [.blue, .red], center: .center, startRadius: 0.0, endRadius: 300.0)
                .ignoresSafeArea()
            VStack {
                Text("Siri Bucks")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Text("Account Balance: $\(Int(vm.bankBalance))")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                    .frame(height: 150)

                Button {
                    vm.fetchBankBalance()
                } label: {
                    Text("Check Balance")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(.black)
                        .cornerRadius(10.0)
                        .padding(.horizontal, 16.0)
                }
            }
        }
        .onAppear {
            vm.fetchBankBalance()
            INPreferences.requestSiriAuthorization { status in
                if status == INSiriAuthorizationStatus.authorized {
                    print("Authorized To Use Siri")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BankAccountView()
    }
}
