//
//  MovieTicketBookingSystem.swift
//  ParkingLot
//
//  Created by Abhilash Palem on 15/11/21.
//

import Foundation

/*
 Actors:
 - Admin
 - FrontDeskOfficer
 - Customer
 - Guest
 - System
 */

fileprivate enum City: Hashable {
    case hyd, chennai, banglore, delhi
}

fileprivate enum Language {
    case telugu, hindi, english
}

fileprivate class BMS {
    private var cityToMovie: [City: [Movie]] = [:]
    private var cityToCinema: [City: [CinemaHall]] = [:]
    
    func getMovies(city: City, date: Date) -> [Movie] {
        return []
    }
    
    func getCinemas(city: City) -> [CinemaHall] {
        return []
    }
    
    func addMovie(movie: Movie, city: City) {}
}

fileprivate class CinemaHall: Identifiable {
    let id: UUID
    let name: String
    let audis: [Audi]
    let address: Address
    
    func getMovies(dates: [Date]) -> [Movie] { [] }
    func getShows(dates: [Date]) -> [Show] { [] }
    
    init(id: UUID = UUID(), name: String, audis: [Audi], address: Address) {
        self.name = name
        self.audis = audis
        self.address = address
        self.id = id
    }
}

fileprivate class Audi: Identifiable {
    let id: UUID
    let name: String
    let totalSeatingCapacity: Int
    let seats: [Seat]
    private(set) var shows: [Show]
    
    init(id: UUID = UUID(), name: String, seats: [Seat]) {
        self.id = id
        self.name = name
        self.seats = seats
    }
    
    func addShow(show: Show) throws -> Bool {
        return true
    }
    
    func cancelShow(id: UUID) throws -> Bool {
        return true
    }
    
}

fileprivate struct Show {
    let id: UUID
    let movie: Movie
    let seats: [Seat]
    let playedAt: CinemaHall
    let audi: Audi
    let startTime: Date
    let endTime: Date
}

fileprivate struct Movie: Identifiable {
    let id: UUID
    let title: String
    let description: String
    let durationInMin: Int
    let language: Language
    let genre: Genre
    let releaseDate: Date
    var cityShowMap: [City: [Show]]
}

fileprivate enum Genre {
    case drama, action, comedy, romance, sci_fi
}

fileprivate class Seat: Identifiable {
    let id: UUID
    let type: SeatType
    
    init(id: UUID = UUID(), type: SeatType = .normal) {
        self.id = id
        self.type = type
    }
}

fileprivate class ShowSeat: Identifiable {
    let id: UUID
    let seat: Seat
    let cost: Double
    let status: SeatStatus
    
    init(id: UUID = UUID(), cost: Double, seat: Seat) {
        self.seat = seat
        self.id = id
        self.cost = cost
    }
}


fileprivate enum SeatType {
    case delux, vip, normal, other
}

fileprivate enum SeatStatus {
    case available, booked, reserved, notAvailable
}


fileprivate protocol MovieSearchable {
    func searchByCity(city: City) -> [Movie]
    func searchByReleaseDate(date: Date) -> [Movie]
    func searchByLanguage(language: Language) -> [Movie]
    func searchByGenre(genre: Genre) -> [Movie]
    func searchByTitle(title: String) -> [Movie]
}

fileprivate struct MovieSearch: MovieSearchable {
    func searchByCity(city: City) -> [Movie] {
        []
    }
    
    func searchByReleaseDate(date: Date) -> [Movie] {
        []
    }
    
    func searchByLanguage(language: Language) -> [Movie] {
        []
    }
    
    func searchByGenre(genre: Genre) -> [Movie] {
        []
    }
    
    func searchByTitle(title: String) -> [Movie] {
        []
    }
}

fileprivate struct Address {
    let street: String
    let city: String
    let state: String
    let country: String
    let zipcode: String
}

fileprivate class Person {
    let account: Account
    let name: String
    let email: String
    let address: Address
    let phone: String
    
    init(account: Account, name: String, email: String, address: Address, phone: String) {
        self.account = account
        self.name = name
        self.email = email
        self.address = address
        self.phone = phone
    }
}

fileprivate class User: Identifiable {
    let id: UUID
    let search: MovieSearchable
    
    init(id: UUID = UUID(), search: MovieSearchable) {
        self.id = id
        self.search = search
    }
}

fileprivate class Guest: User {
    func registerAccount(){}
}

fileprivate class Customer: Person {
    
    init() {}
    
    func makeBooking(booking: Booking) {}
    func getAllBookings() -> [Booking] {}
}

fileprivate class Account {
    let userName: String
    let password: String
    
    func resetPassword() -> Bool { true }
    
    init(userName: String, password: String) {
        self.userName = userName
        self.password = password
    }
}

fileprivate class Booking {
    let id: UUID
    let person: Person
    let status: BookingStatus
    let bookingDate: Date
    let payment: Payment?
    let show: Show
    let audi: Audi
    let seats: [Seat]
    
    init(id: UUID = UUID(), person: Person, show: Show, audi: Audi, seats: [Seat]) {
        self.id = id
        self.person = person
        self.show = show
        self.audi = audi
        self.seats = seats
    }
    
    func makePayment(payment: Payment) -> Bool {
        
    }
}

fileprivate class Payment {
    let paymentDate: Date
    let transactionId: String
    let amount: Double
    let status: PaymentStatus
    
    init(paymentDate: Date = Date(), transactionId: String, amount: Double, status: PaymentStatus) {
        self.paymentDate = paymentDate
        self.transactionId = transactionId
        self.amount = amount
        self.status = status
    }
}

enum BookingStatus {
    case requested, pending, confirmed, cancelled, refunded
}

enum PaymentStatus {
    case unpaid, pending, completed, cancelled, declined, refunded
}
