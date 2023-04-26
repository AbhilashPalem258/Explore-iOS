//
//  WebsocketUtility.swift
//  URLLoadingSystem
//
//  Created by Abhilash Palem on 15/10/22.
//

import Foundation
extension String: Error {}

class Websocket: NSObject {
    
    var session: URLSession?
    var task: URLSessionWebSocketTask?
    var onMessageReceived: ((String) -> Void)?
    
    init?(urlString: String, onMessageReceived: @escaping (String) -> Void) {
        super.init()
        session = SessionFactory.createSocketSession(delegate: self)
        guard let session = session, let url = URL(string: urlString) else {
            return nil
        }

        self.onMessageReceived = onMessageReceived
        task = session.webSocketTask(with: url)
        task?.resume()
    }
}
extension Websocket: URLSessionWebSocketDelegate {
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("Did connected to Socket")
    }
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("Did closed connection to Socket")
    }
}
extension Websocket {
    func ping() {
        task?.sendPing { error in
            if let error = error {
                print("Failed to send ping with error: \(String(describing: error.localizedDescription))")
            } else {
                self.receiveHandler()
            }
        }
    }
    
    func close() {
        task?.cancel(with: .goingAway, reason: "Done with the demo".data(using: .utf8))
    }
    
    func receiveHandler() {
        task?.receive {[weak self] result in 
            switch result {
            case .success(let msg):
                switch msg {
                case .string(let msgStr):
                    DispatchQueue.main.async {
                        self?.onMessageReceived?(msgStr)
                    }
                case .data(let data):
                    let str = String(data: data, encoding: .utf8)
                    DispatchQueue.main.async {
                        self?.onMessageReceived?(str!)
                    }
                default:
                    break
                }
            case .failure(let error):
                print("Failed to Receive Message with error: \(error.localizedDescription)")
            }
            
            self?.receiveHandler()
        }
    }
    
    func sendMessage(_ msg: String) {
        task?.send(.string(msg)) { error in
            if let error = error {
                print("Failed to send message with error: \(String(describing: error.localizedDescription))")
            } else {
                self.receiveHandler()
            }
        }
    }
}
