//
//  LMS.swift
//  LIbraryManagementSystem
//
//  Created by Abhilash Palem on 17/11/21.
//

import Foundation

/*
 System Components:
 - Library
 - LirarySearch
 - Book
 - Book Item
 - Rack
 - Fine
 - NotificationService
 
 Actors:
 - Librarian
 - LibraryMember
 - Author
 - System
 
 UseCase:
 - Add/Remove/Edit Book
 - Search Books By Title,Author, Subject category, Publication date
 - Register New Account/ Cancel membership
 - Reserve Book
 - Checkout Book
 - Renew Book
 - Return Book
 */

class Library: Identifiable {
    let id: UUID
    let name: String
    let address: Address
    private var books: [BookItem] = []
    
    init(id: UUID = UUID(), name: String, address: Address) {
        self.id = id
        self.name = name
        self.address = address
    }
}

struct Address {
    let street: String
    let district: String
    let city: String
    let state: String
    let country: String
    let pinCode: Int
}

struct Book {
    let id: UUID
    let name: String
    let authors: [Author]
    let type: BookType
}

class BookItem {
    let id: UUID
    let publicationDate: Date
    let book: Book
    let status: BookStatus
    let format: BookFormat
    
    init(id: UUID = UUID(), publicationDate: Date = Date(), book: Book, format: BookFormat) {
        self.id = id
        self.publicationDate = publicationDate
        self.book = book
        self.format = format
        self.status = .available
    }
}

enum BookType {
    case sci_fi, drama, thriller, horror, fantasy
}

enum BookStatus {
    case available, issued, reserved, notAvailable
}

enum BookFormat {
    case hardcover, backpaper, newspaper, journal
}

struct Author {
    let name: String
    
    func getPublishedBooks() -> [Book]{[]}
}

struct Account {
    let username: String
    let password: String
    let status: AccountStatus
    
    func resetPassword() {}
}

enum AccountStatus {
    case active, closed, cancelled, blacklisted, blocked
}

struct Person {
    let name: String
    let address: Address
    let email: String
    let mobile: String
    let account: Account
}

class LibraryMember {
    let person: Person
    let card: LibraryCard
    let bookSearch: BookSearchable
    
    let totalCountOfCheckedoutBooks: Int
    
    init(person: Person, card: LibraryCard) {
        self.person = person
        self.card = card
    }
}

struct LibraryCard {
    let barcode: String
}

class Librarian {
    let person: Person
    let bookSearch: BookSearchable
    
    func addBook(book: BookItem) {}
    func removeBook(book: BookItem){}
    func updateBook(book: BookItem){}
    
    func registerMember(person: Person) -> LibraryMember {
        return .init(person: .init(name: "", address: "", email: "", mobile: "", account: .init(username: "", password: "", status: .active)), card: .init(barcode: ""))
    }
}

protocol BookSearchable {
    func getBooks(title: String) -> [BookItem]
    func getBooks(publicationDate: Date) -> [BookItem]
    func getBooks(category: BookType) -> [BookItem]
    func getBooks(author: Author) -> [Author]
}

struct BookSearch: BookSearchable {
    
    let library: Library
    
    func getBooks(title: String) -> [BookItem] {
        []
    }
    
    func getBooks(publicationDate: Date) -> [BookItem] {
        []
    }
    
    func getBooks(category: BookType) -> [BookItem] {
        []
    }
    
    func getBooks(author: Author) -> [Author] {
        []
    }
}

class BookIssueService {
    let fineService: FineService
    
    func getBookReservationDetails(book: BookItem) -> BookReservationDetails {}
    func updateBookReservationDetails(reservationdetails: BookReservationDetails) {}
    func reserveBook(book: BookItem) -> BookReservationDetails {}
    func issueBook(book: BookItem, member: LibraryMember) -> BookIssueDetails {}
    func renewBook(book: BookItem, member: LibraryMember) -> BookIssueService {}
    func returnBook(book: BookItem, member: LibraryMember) {}
}

struct FineService {
    static func calculateFine(member: LibraryMember, book: BookItem, dueDays: Int) -> Fine {}
}

struct Fine {
    let id: UUID
    let fineDate: Date
    let amount: Double
    let book: BookItem
    let member: LibraryMember
}

class BookLending {
    let book: BookItem
    let startDate: Date
    let member: LibraryMember
    
    init() {
        
    }
}

class BookReservationDetails: BookLending {
    let status: BookReservationStatus
}

class BookIssueDetails: BookLending {
    let dueDate: Date
}

enum BookReservationStatus {
    case done, unavailable, not_possible
}
