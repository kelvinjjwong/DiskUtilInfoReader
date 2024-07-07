//
//  File.swift
//  
//
//  Created by Kelvin Wong on 2024/7/2.
//

import Foundation

public class DiskInfo {
    
    var deviceProtocol = ""
    var deviceIdentifier = ""
    var partOfWhole = ""
    var whole = ""
    var mountPoint = ""
    var mounted = ""
    var volumeName = ""
    var deviceMediaName = ""
    var diskSize = ""
    var deviceLocation = ""
    var solidState = ""
    var fileSystem = ""
    var name = ""
    var volumeTotalSpace = ""
    var volumeFreeSpace = ""
    var smartStatus = ""
    var containerTotalSpace = ""
    var containerFreeSpace = ""
    
    public init() {}
    
    public func totalSpace() -> String {
        if self.fileSystem == "APFS" {
            return self.containerTotalSpace
        }else{
            return self.volumeTotalSpace
        }
    }
    
    public func freeSpace() -> String {
        if self.fileSystem == "APFS" {
            return self.containerFreeSpace
        }else{
            return self.volumeFreeSpace
        }
    }
}
