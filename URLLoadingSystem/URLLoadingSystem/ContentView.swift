//
//  ContentView.swift
//  URLLoadingSystem
//
//  Created by Abhilash Palem on 15/10/22.
//

import SwiftUI

class SocketViewVM: ObservableObject {
    
    var webSocket: Websocket? = nil
    @Published var msgReceivedFromSocket = ""
    
    func configureSocket() {
        webSocket = Websocket(urlString: "wss://demo.piesocket.com/v3/channel_1?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self") {[weak self] msg in
            self?.msgReceivedFromSocket = msg
        }
    }
}

fileprivate struct DefaultButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.black)
            .cornerRadius(10)
            .padding(.horizontal)
    }
}

struct ContentView: View {
    
    @StateObject var vm = SocketViewVM()
    @State private var sendMsgText = ""

    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            VStack {
                Button {
                    vm.webSocket?.ping()
                } label: {
                    Text("Ping")
                        .modifier(DefaultButton())
                }
                
                Text("Received Message: \(vm.msgReceivedFromSocket)")
                    .font(.headline)
                    .foregroundColor(.black)
                
                TextField("Enter Message", text: $sendMsgText)
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                
                Button {
                    vm.webSocket?.sendMessage(sendMsgText)
                } label: {
                    Text("Send Message")
                        .modifier(DefaultButton())
                }
            }
        }
        .onAppear {
            vm.configureSocket()
        }
        .onDisappear {
            vm.webSocket?.close()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
