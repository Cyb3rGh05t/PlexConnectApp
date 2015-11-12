//
//  Settigns.swift
//  PlexConnectApp
//
//  Created by Baa on 28.10.15.
//  Copyright © 2015 Baa. All rights reserved.
//

import Foundation
import TVMLKit



@objc protocol jsInterfaceProtocol : JSExport {
    func log(message: String) -> Void
    
    // XMLConverter
    func getView(view: String, id: String, path: String) -> String
    
    // Settings
    func toggleSetting(setting: String, view: String) -> String
    
    // PlexAPI
    func discover(view: String) -> String
    func signInUser(username: String, password: String, view: String) -> String
    func signOut(view: String) -> String
}



class cJsInterface: NSObject, jsInterfaceProtocol {
    func log(message: String) -> Void {
        print("JS: \(message)")
    }
    
    // XMLConverter
    func getView(view: String, id: String, path: String) -> String {
        let processor = cXmlConverter()  // new class instance each time? or just re-setup and run?
        processor.setup(view+".xml", pmsId: id, pmsPath: path, query: [:])
        
        let TVMLTemplate = processor.doIt()
        return TVMLTemplate
    }
    
    // Settings
    func toggleSetting(setting: String, view: String) -> String {
        settings.toggleSetting(setting)
        
        return getView(view, id: "", path: "")
    }
    
    // PlexAPI
    func discover(view: String) -> String {
        discoverServers()
        return getView(view, id: "", path: "")
    }
    
    func signInUser(username: String, password: String, view: String) -> String {
        myPlexSignIn(username, password: password)
        return getView(view, id: "", path: "")
    }
    
    func signOut(view: String) -> String {
        myPlexSignOut()
        return getView(view, id: "", path: "")
    }
}
