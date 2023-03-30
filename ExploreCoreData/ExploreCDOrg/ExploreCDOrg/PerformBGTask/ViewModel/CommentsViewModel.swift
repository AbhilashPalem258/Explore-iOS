//
//  CommentsViewModel.swift
//  ExploreCDOrg
//
//  Created by Abhilash Palem on 31/01/23.
//
import Combine
import CoreData
import SwiftUI
import OSLog

/*
 - BatchInsert Using Traditional
 */

class CommentsViewModel: NSObject, ObservableObject {
    @Published var comments: [Comment] = []
    private let commentsFetchedController: NSFetchedResultsController<CDComment>
    private var cancellables = Set<AnyCancellable>()
    
    enum CDInsertType {
        case traditional
        case nsBatchInsert
    }
    
    override init() {
        let fetchRequest = NSFetchRequest<CDComment>(entityName: String(describing: CDComment.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \CDComment.name, ascending: true)]
        fetchRequest.fetchBatchSize = 6
        
        commentsFetchedController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: PersistentStorage.shared.context, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
//        commentsFetchedController.delegate = self
    }
    
    func performFetch() {
        do {
            try commentsFetchedController.performFetch()
            if let fetchedObjs = commentsFetchedController.fetchedObjects {
                DispatchQueue.main.async {
                    self.comments = fetchedObjs.map{$0.convertToComment()}
                }
            }
        } catch {
            Logger.CoreData.error("Failed to fetch CDComments")
        }
    }
    
    
    
    func fetchCommentsFromAPI(type: CDInsertType = .nsBatchInsert) {
        CommentsDataService.fetchPosts()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    Logger.CoreData.error("Failed to fetch Comments API: \(error.localizedDescription)")
                case .finished:
                    Logger.CoreData.info("Comments API Fetching successful")
                }
            } receiveValue: { comments in
                if type == .traditional {
                    CDCommentsService.insertItemsUsingTraditionalBatchInsert(comments)
                        .sink { [self] isSaved in
                            if isSaved {
                                performFetch()
                            }
                        }
                        .store(in: &self.cancellables)
                } else {
                    CDCommentsService.inserItemsUsingNSBatchInsertRequest(comments)
                        .sink { [self] isSaved in
                            if isSaved {
//                                performFetch()
                                fetchCDComments()
                            }
                        }
                        .store(in: &self.cancellables)
                }
            }
            .store(in: &cancellables)
    }
    
    func DeleteAll() {
        CDCommentsService.DeleteAll()
        performFetch()
    }
    
    func fetchCDComments() {
        CDCommentsService.fetchAllItemsUsingAsynchronousRequest()
            .sink { completion in
                if case .failure(let error) = completion {
                    Logger.CoreData.error("Failed Fetching Items: \(error.localizedDescription)")
                }
            } receiveValue: { comments in
                DispatchQueue.main.async {
                    self.comments = comments.map{$0.convertToComment()}
                }
            }
            .store(in: &cancellables)
    }
}

struct CommentsView: View {
    
    @StateObject private var vm = CommentsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.comments) { comment in
                    Text(comment.email)
                }
            }
            .onAppear {
                vm.fetchCommentsFromAPI()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        vm.DeleteAll()
                    } label: {
                        Image(systemName: "trash")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                }
            }
        }
    }
}

public class CustomClassForCDEntity: NSObject, Codable {
    public let name: String
    public init(name: String) {
        self.name = name
        super.init()
    }
}

//https://stackoverflow.com/questions/32597065/core-data-no-nsvaluetransformer-with-class-name-xxx-was-found-for-attribute-yy
@objc(CustomClassForCDEntityTransformer)
class CustomClassForCDEntityTransformer: ValueTransformer {
    override func transformedValue(_ value: Any?) -> Any? {
        guard let obj = value as? CustomClassForCDEntity else {
            print("\(#function) cast issue")
            return nil
        }
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: obj, requiringSecureCoding: true)
            return data
        } catch {
            print(error)
            return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else {
            print("\(#function) cast issue")
            return nil
        }
        
        do {
            let obj = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [CustomClassForCDEntity.self, NSString.self], from: data)
            return obj
        } catch {
            print(error)
            return nil
        }
    }
}
