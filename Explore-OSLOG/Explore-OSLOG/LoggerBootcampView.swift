//
//  ContentView.swift
//  Explore-OSLOG
//
//  Created by Abhilash Palem on 29/10/22.
//

import SwiftUI
import OSLog

fileprivate struct DefaultBtn: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .padding(.horizontal)
            .background(.black)
            .cornerRadius(10.0)
    }
}

extension View {
    func defaultButton() -> some View {
        self
            .modifier(DefaultBtn())
    }
}

extension Logger {
    static let bootcamp = Logger(subsystem: "com.abhilash.Explore_OSLOG", category: "bootcamp")
}

extension OSLog {
    static let signpost = OSLog(subsystem:  "com.abhilash.Explore_OSLOG", category: "signpost")
}

class ViewModel {
    func pressedOnLogMessage() {
        for i in 0..<10 {
            if i % 2 == 0 {
                Logger.bootcamp.info("Info Log Message \(i), Name: \("Abhilash", privacy: .public)")
            } else {
                Logger.bootcamp.info("Info Log Message \(i), Name: \("Abhilash", privacy: .private)")
            }
        }
    }
    
    func pressOnSignPostMetric() {
        os_signpost(.begin, log: OSLog.signpost, name: "Begin: Pressed On SignPost Measurenment")
        Thread.sleep(forTimeInterval: 3.0)
        os_signpost(.end, log: OSLog.signpost, name: "Begin: Pressed On SignPost Measurenment")
    }
}

struct LoggerBootcampView: View {
    
    private let vm: ViewModel
    
    init(vm: ViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [.red, .blue], center: .center, startRadius: 0, endRadius: 200)
            VStack {
                Button {
                    vm.pressedOnLogMessage()
                } label: {
                    Text("Log Message")
                        .defaultButton()
                }
                
                Button {
                    vm.pressOnSignPostMetric()
                } label: {
                    Text("Log SignPost Measure")
                        .defaultButton()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoggerBootcampView(vm: ViewModel())
    }
}
