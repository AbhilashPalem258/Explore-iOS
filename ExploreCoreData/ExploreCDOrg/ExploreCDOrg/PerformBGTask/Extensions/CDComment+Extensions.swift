//
//  CDComment+Extensions.swift
//  ExploreCDOrg
//
//  Created by Abhilash Palem on 31/01/23.
//

import Foundation

extension CDComment {
    func convertToComment() -> Comment {
        Comment(postId: self.postId, id: self.id, name: self.name ?? "", email: self.email ?? "", body: self.body ?? "", customVal: .init(name: self.name ?? ""))
    }
}
