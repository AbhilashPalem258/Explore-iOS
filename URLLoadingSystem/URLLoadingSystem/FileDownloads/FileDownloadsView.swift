//
//  FileDownloader.swift
//  URLLoadingSystem
//
//  Created by Abhilash Palem on 15/10/22.
//

import Foundation
import SwiftUI

struct FileDownloadInfo: Identifiable {
    let id: Int
    let name: String
    let path: String
    var isDownloading = false
    var downloadComplete = false
    var downloadProgress = 0.0
}

class FileDownloadsViewModel: ObservableObject {
    private var fileDownloadUtility: FileDownloadUtility?
    @Published var fileDownloadInfo: [FileDownloadInfo] = [
        .init(
            id: 0,
            name: "iOS Programming Guide",
            path: "https://developer.apple.com/library/ios/documentation/iphone/conceptual/iphoneosprogrammingguide/iphoneappprogrammingguide.pdf"
        ),
        .init(
            id: 1,
            name: "Human Interface Guidelines",
            path: "https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/MobileHIG/MobileHIG.pdf"
        ),
        .init(
            id: 2,
            name: "Networking Overview",
            path: "https://developer.apple.com/library/ios/documentation/NetworkingInternetWeb/Conceptual/NetworkingOverview/NetworkingOverview.pdf"
        ),
        .init(
            id: 3,
            name: "AV Foundation",
            path: "https://developer.apple.com/library/ios/documentation/AudioVideo/Conceptual/AVFoundationPG/AVFoundationPG.pdf"
        ),
        .init(
            id: 4,
            name: "Research Gate Guide",
            path: "https://research.nhm.org/pdfs/10840/10840.pdf"
        ),
        .init(
            id: 5,
            name: "iPhone User Guide",
            path: "http://manuals.info.apple.com/MANUALS/1000/MA1565/en_US/iphone_user_guide.pdf"
        )
    ]
    
    func configureTasks() {
        fileDownloadUtility = FileDownloadUtility(requests: fileDownloadInfo.map{ URL(string: $0.path) }.compactMap{ $0 })
        fileDownloadUtility?.delegate = self
    }
    
    func startAllDownloads() {
        fileDownloadUtility?.startAllDownloads()
    }
    
    func startDownload(id: Int) {
        fileDownloadUtility?.startDownload(id: id)
    }
    
    func pauseDownload(id: Int) {
        fileDownloadUtility?.pauseDownload(id: id)
    }
    
    func resumeDownload(id: Int) {
        fileDownloadUtility?.resumeDownload(id: id)
    }
    
    func stopDownload(id: Int) {
        fileDownloadUtility?.stopDownload(id: id)
    }
    
    func getFileData(id: Int) -> Data? {
        if let fileName = URL(string: fileDownloadInfo[id].path)?.lastPathComponent,
           let fileURL = FileManagerHelper.shared.getFilePath(name: fileName) {
            do {
                return try Data(contentsOf: fileURL)
            } catch {
                print(error)
            }
        }
        return nil
    }
}
extension FileDownloadsViewModel: FileDownloadUtilityDelegate {
    func update(response: FileDownloadResponse) {
        let index = response.id
        var fileDownloadModel = fileDownloadInfo[index]
        fileDownloadModel.isDownloading = response.isDownloading
        fileDownloadModel.downloadComplete = response.downloadComplete
        fileDownloadModel.downloadProgress = response.downloadProgress ?? fileDownloadModel.downloadProgress
        
        DispatchQueue.main.async {
            self.fileDownloadInfo[index] = fileDownloadModel
        }
    }
}

fileprivate struct DefaultButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.white)
            .cornerRadius(10)
            .padding(.horizontal)
    }
}

struct FileDownloadsView: View {
    @StateObject var vm = FileDownloadsViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack {
                        ForEach(vm.fileDownloadInfo) { item in
                            NavigationLink {
                                if let data = vm.getFileData(id: item.id) {
                                    PDFKitRepresentedView(data)
                                }
                            } label: {
                                FileDownloadItemView(item: item)
                                    .environmentObject(vm)
                            }
                        }
                        Spacer()
                            .frame(height: 20)
                        Button {
                            vm.startAllDownloads()
                        } label: {
                            Text("Start All Downloads")
                                .modifier(DefaultButton())
                        }
                        
                        Button {
                            
                        } label: {
                            Text("Stop All Downloads")
                                .modifier(DefaultButton())
                        }
                    }
                }
                .padding(.horizontal)
            }
            .onAppear {
                vm.configureTasks()
            }
            .navigationTitle("BG Transfer Demo")
        }
    }
}

fileprivate struct MediaPlayPauseButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .foregroundColor(.black)
            .padding(10)
            .background(.yellow)
    }
}

struct FileDownloadItemView: View {
    
    let item: FileDownloadInfo
    @EnvironmentObject var vm: FileDownloadsViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text(item.name)
                    .font(.headline)
                Spacer()
                if item.downloadComplete {
                    Text("Ready")
                        .font(.footnote)
                        .foregroundColor(.green)
                } else {
                    HStack {
                        if !item.isDownloading {
                            Button {
                                item.downloadProgress == 0.0 ? vm.startDownload(id: item.id) : vm.resumeDownload(id: item.id)
                            } label: {
                                Image(systemName: "play")
                                    .modifier(MediaPlayPauseButton())
                            }
                        } else {
                            Button {
                                vm.pauseDownload(id: item.id)
                            } label: {
                                Image(systemName: "pause")
                                    .modifier(MediaPlayPauseButton())
                            }
                        }
                        Button {
                            vm.stopDownload(id: item.id)
                        } label: {
                            Image(systemName: "stop")
                                .modifier(MediaPlayPauseButton())
                                .opacity(!item.isDownloading ? 0.5 : 1.0)
                        }
                        .disabled(!item.isDownloading)
                    }
                }
            }
            ProgressView("", value: item.downloadProgress)
        }
    }
}

struct FileDownloadsView_Previews: PreviewProvider {
    static var previews: some View {
        FileDownloadsView()
    }
}
