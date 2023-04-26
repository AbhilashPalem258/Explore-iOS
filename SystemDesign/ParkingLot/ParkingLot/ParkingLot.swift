//
//  ParkingLot.swift
//  ParkingLot
//
//  Created by Abhilash Palem on 12/11/21.
//

import Foundation

enum VehicleSize {
    case motorCycle, compact, large
}

class Vehicle {
    let number: String
    let size: VehicleSize
    private var parkingSpot: ParkingSpot?
    
    init(number: String, size: VehicleSize) {
        self.number = number
        self.size = size
    }
    
    func park(in spot: ParkingSpot) {
        self.parkingSpot = spot
    }
    
    func unpark() {
        self.parkingSpot = nil
    }
}

class ParkingLot {
    let levels: [Level]
    
    init(levels: [Level]) {
        self.levels = levels
    }
}

enum ParkingEntry {
    case north, south, east, west
}

class Level {
    let floor: Int
    private(set) var spots: [ParkingSpot] = []
    let rows: Int
    let SPOTS_PER_ROW: Int
    private(set) var nextParkSpot: Int
    var availableSpots: Int {
        (rows * SPOTS_PER_ROW) - nextParkSpot - 1
    }
    
    init(floor: Int, rows: Int = 4, spotsPerRow: Int = 8) {
        self.floor = floor
        self.rows = rows
        self.SPOTS_PER_ROW = spotsPerRow
        self.nextParkSpot = 1
        for row in 0..<self.rows {
            for num in 0..<self.SPOTS_PER_ROW {
                self.spots.append(.init(size: .compact, level: self, row: row, spotNumber: num))
            }
        }
    }
    
    func park(vehicle: Vehicle) {
        let spot = findNextAvailableSpot()
        spot.park(vehicle: vehicle)
        self.nextParkSpot += 1
    }
    
    func findNextAvailableSpot() -> ParkingSpot {
        return .init(size: .compact, level: self, row: nextParkSpot/SPOTS_PER_ROW, spotNumber: nextParkSpot)
    }
    
    func removeVehicle(vehicle: Vehicle) {
        vehicle.unpark()
    }
    
}

class ParkingSpot {
    let size: VehicleSize
    private(set) var vehicle: Vehicle?
    let level: Level
    let row: Int
    let spotNumber: Int
    
    var isAvailable: Bool {
        return vehicle == nil
    }
    
    init(size: VehicleSize, level: Level, row: Int, spotNumber: Int) {
        self.size = size
        self.level = level
        self.row = row
        self.spotNumber = spotNumber
    }
    
    func park(vehicle: Vehicle) {
        self.vehicle = vehicle
    }
    
    func removeVehicle() {
        self.vehicle = nil
    }
}
