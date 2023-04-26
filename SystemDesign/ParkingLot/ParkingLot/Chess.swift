//
//  Chess.swift
//  ParkingLot
//
//  Created by Abhilash Palem on 14/11/21.
//

import Foundation

//Account
fileprivate struct Address {
    let street: String
    let city: String
    let state: String
    let country: String
    let zipcode: String
}

fileprivate struct Person {
    let name: String
    let address: Address
    let email: String
    let mobile: String
}

fileprivate struct Account {
    let id: UUID
    let Person: Person
    let password: String
    
    func resetPassword() {
        
    }
}

class Player {
    let person: Person
    let totalGamesPlayed: Int
    let isWhiteSide: Bool
    
    init(person: Person, totalGamesPlayed: Int, isWhiteSide: Bool) {
        self.person = person
        self.totalGamesPlayed = totalGamesPlayed
        self.isWhiteSide = isWhiteSide
    }
}

enum GameStatus {
    case active
    case forfiet
    case stalemate
    case resignation
    case whiteWin
    case blackWin
}

enum chessError: Error {
    case noPieceFound
}

class ChessGame {
    private var movesPlayed: [Move] = []
    var currentPlayer: Player
    let whitePlayer: Player
    let blackPlayer: Player
    let board: Board
    var status: GameStatus
    
    init(whitePlayer: Player, blackPlayer: Player, board: Board) {
        self.whitePlayer = whitePlayer
        self.blackPlayer = blackPlayer
        self.status = .active
        self.currentPlayer = self.whitePlayer
        self.board = board
    }
    
    func move(start: ChessPosition, end: ChessPosition) throws {
//        if start.isEmpty {
//            throw chessError.noPieceFound
//        }
//        if start.piece!.canMove(board: board, start: start, end: end) {
//
//        }
    }
    
}



class Piece {
    private(set) var isKilled = false
    private(set) var isWhite = false
    
    init(isWhite: Bool) {
        self.isWhite = isWhite
    }
    
    
    func setKilled() {
        self.isKilled = true
    }
    
    func canMove(board: Board, start: Box, end: Box) -> Bool {
        fatalError("Can Move method not implemented")
    }
}

class Pawn: Piece {
    override func canMove(board: Board, start: Box, end: Box) -> Bool {
        //Implementation for able to move
        if end.piece?.isWhite == self.isWhite || start.col > end.col {
            return false
        }
        
        let diffX = abs(end.row - start.row)
        let diffY = abs(end.col - start.col)
        if diffX + diffY == 2 && !end.isEmpty {
            return true
        }
        
        if diffX + diffY == 1 && end.isEmpty {
            return true
        }
        
        return true
    }
}

class Rook: Piece {
    override func canMove(board: Board, start: Box, end: Box) -> Bool {
        //Implementation for able to move
        return true
    }
}

class Knight: Piece {
    override func canMove(board: Board, start: Box, end: Box) -> Bool {
        //Implementation for able to move
        if end.piece?.isWhite == self.isWhite {
            return false
        }
        
        let diffX = abs(start.row - end.row)
        let diffY = abs(start.col - end.col)
        return diffX * diffY == 2
    }
}

class Bishop: Piece {
    override func canMove(board: Board, start: Box, end: Box) -> Bool {
        //Implementation for able to move
        if end.piece?.isWhite == self.isWhite {
            return false
        }
        let diffX = abs(start.row - end.row)
        let diffY = abs(start.col - end.col)
        if diffX == diffY {
            // and if no pieces in the path
            return true
        }
        return false
    }
}

class Queen: Piece {
    override func canMove(board: Board, start: Box, end: Box) -> Bool {
        //Implementation for able to move
        return true
    }
}

class King: Piece {
    override func canMove(board: Board, start: Box, end: Box) -> Bool {
        //Implementation for able to move
        if end.piece?.isWhite == self.isWhite {
            return false
        }
        
        let diffX = abs(start.row - end.row)
        let diffY = abs(start.col - end.col)
        return [1,2].contains(diffX + diffY)
    }
}

struct Move {
    let player: Player
    let start: Box
    let end: Box
    let pieceKilled: Piece?
    let isCastlingMove: Bool
}


class Board {
    var boxes: [[Box]] = [[Box]]()
    let createdAt: Date
    
    init(dateProvider: () -> Date) {
        self.createdAt = dateProvider()
        self.initializePiecesOnBoard()
    }
    
    func initializePiecesOnBoard() {
        boxes.append([
            Box.init(row: 0, col: 0, piece: Rook(isWhite: true)),
            Box.init(row: 0, col: 1, piece: Knight(isWhite: true)),
            Box.init(row: 0, col: 2, piece: Bishop(isWhite: true)),
            Box.init(row: 0, col: 3, piece: King(isWhite: true)),
            Box.init(row: 0, col: 4, piece: Queen(isWhite: true)),
            Box.init(row: 0, col: 5, piece: Bishop(isWhite: true)),
            Box.init(row: 0, col: 6, piece: Knight(isWhite: true)),
            Box.init(row: 0, col: 7, piece: Rook(isWhite: true))
        ])
        
        boxes.append([
            Box.init(row: 1, col: 0, piece: Pawn(isWhite: true)),
            Box.init(row: 1, col: 1, piece: Pawn(isWhite: true)),
            Box.init(row: 1, col: 2, piece: Pawn(isWhite: true)),
            Box.init(row: 1, col: 3, piece: Pawn(isWhite: true)),
            Box.init(row: 1, col: 4, piece: Pawn(isWhite: true)),
            Box.init(row: 1, col: 5, piece: Pawn(isWhite: true)),
            Box.init(row: 1, col: 6, piece: Pawn(isWhite: true)),
            Box.init(row: 1, col: 7, piece: Pawn(isWhite: true))
        ])
        
        for row in 2..<6 {
            boxes.append([
                Box.init(row: row, col: 0),
                Box.init(row: row, col: 1),
                Box.init(row: row, col: 2),
                Box.init(row: row, col: 3),
                Box.init(row: row, col: 4),
                Box.init(row: row, col: 5),
                Box.init(row: row, col: 6),
                Box.init(row: row, col: 7)
            ])
        }
        
        boxes.append([
            Box.init(row: 6, col: 0, piece: Pawn(isWhite: false)),
            Box.init(row: 6, col: 1, piece: Pawn(isWhite: false)),
            Box.init(row: 6, col: 2, piece: Pawn(isWhite: false)),
            Box.init(row: 6, col: 3, piece: Pawn(isWhite: false)),
            Box.init(row: 6, col: 4, piece: Pawn(isWhite: false)),
            Box.init(row: 6, col: 5, piece: Pawn(isWhite: false)),
            Box.init(row: 6, col: 6, piece: Pawn(isWhite: false)),
            Box.init(row: 6, col: 7, piece: Pawn(isWhite: false))
        ])
        
        boxes.append([
            Box.init(row: 7, col: 0, piece: Rook(isWhite: false)),
            Box.init(row: 7, col: 1, piece: Knight(isWhite: false)),
            Box.init(row: 7, col: 2, piece: Bishop(isWhite: false)),
            Box.init(row: 7, col: 3, piece: King(isWhite: false)),
            Box.init(row: 7, col: 4, piece: Queen(isWhite: false)),
            Box.init(row: 7, col: 5, piece: Bishop(isWhite: false)),
            Box.init(row: 7, col: 6, piece: Knight(isWhite: false)),
            Box.init(row: 7, col: 7, piece: Rook(isWhite: false))
        ])
    }
    
    func reset() {
        self.initializePiecesOnBoard()
    }
}

struct ChessPosition {
    let row: Int
    let col: Int
}

class Box {
    let position: ChessPosition
    private(set) var piece: Piece?
    var isEmpty: Bool {
        piece == nil
    }
    
    init(position: ChessPosition, piece: Piece? = nil) {
        self.position = position
        self.piece = piece
    }
    
    func setPiece(piece: Piece?) {
        self.piece = piece
    }
}
