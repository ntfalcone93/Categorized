//
//  NotesController.swift
//  Categorized
//
//  Created by Nathan on 1/16/16.
//  Copyright © 2016 FalcOne Development. All rights reserved.
//

import Foundation

class NotesController: NSObject {
    
    static let sharedInstance = NotesController()
    
    var categories: [Category] = []
    var notesInCategory: [Note] = []
    
    // Create User
    func createUser() {
        
    }
    
//    func createCategory(title: String, caption: String, completion: (key: String) -> ()) {
//        
//    }
}

/*
func createPlaylistWithTitle(title: String, description: String, completion:(key: String?) -> ()) {
let allPlaylistsRef = rootRef.childByAppendingPath("playlists")
let specificPlaylistRef = allPlaylistsRef.childByAutoId()
let playlist = Playlist(title: title, playlistDescription: description)
specificPlaylistRef.setValue(playlist.toAnyObject()) { (error, firebase) -> Void in
if error == nil {
completion(key: firebase.ref!.key)
} else {
print("Error getting key while creating playlist: \(error.localizedDescription)")
completion(key: nil)
}
}
specificPlaylistRef.setValue(playlist.toAnyObject())
}
*/