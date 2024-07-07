import Foundation

public class DiskUtilInfoReader {
    
    public init() {}
    
    public func read() -> [String:DiskInfo] {
        let pipe = Pipe()
        let pipe2 = Pipe()
        
        let exiftool = Process()
        exiftool.standardOutput = pipe
        exiftool.standardError = pipe2
        exiftool.launchPath = "/usr/sbin/diskutil"
        exiftool.arguments = ["info", "-all"]
        exiftool.launch()
//            exiftool.waitUntilExit()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let err = pipe2.fileHandleForReading.readDataToEndOfFile()
        let output:String = String(data: data, encoding: String.Encoding.utf8)!
        let errStr:String = String(data: err, encoding: .utf8)!
        if errStr.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            // print error
            print(errStr)
        }
        pipe.fileHandleForReading.closeFile()
        pipe2.fileHandleForReading.closeFile()
        
        var list:[String:[String:String]] = [:]
        
        let lines = output.components(separatedBy: "\n")
        
        print("got \(lines.count) lines")
        
        var rows:[String:String] = [:]
        for line in lines {
            if line != "" {
                if line.starts(with: "**********") {
                    if !rows.isEmpty, let deviceIdentifier = rows["Device Identifier"] {
                        list[deviceIdentifier] = rows
                    }
                    rows = [:]
                }else{
                    let cols = line.components(separatedBy: ":")
                    rows[cols[0].trimmingCharacters(in: .whitespacesAndNewlines)] = cols[1].trimmingCharacters(in: .whitespacesAndNewlines)
                }
            }
        }
        
        var disks:[String:DiskInfo] = [:]
        
        for (id, disk) in list {
            if disk["Protocol"]  == "EFI" || disk["Volume Name"]  == "EFI" || disk["Volume Name"]  == "Not applicable (no file system)" {
                continue
            }
            let di = DiskInfo()
            di.deviceIdentifier = id
            for (k,v) in disk {
                if k == "Part of Whole" {
                    di.partOfWhole = v
                }
                if k == "Whole" {
                    di.whole = v
                }
                if k == "Mount Point" {
                    di.mountPoint = v
                }
                if k == "Mounted" {
                    di.mounted = v
                }
                if k == "Volume Name" {
                    di.volumeName = v
                }
                if k == "Device / Media Name" {
                    di.deviceMediaName = v
                }
                if k == "Protocol" {
                    di.deviceProtocol = v
                }
                if k == "Disk Size" {
                    di.diskSize = v
                }
                if k == "Device Location" {
                    di.deviceLocation = v
                }
                if k == "Solid State" {
                    di.solidState = v
                }
                if k == "File System Personality" {
                    di.fileSystem = v
                }
                if k == "Name (User Visible)" {
                    di.name = v
                }
                if k == "Volume Total Space" {
                    di.volumeTotalSpace = v
                }
                if k == "Volume Free Space" {
                    di.volumeFreeSpace = v
                }
                if k == "SMART Status" {
                    di.smartStatus = v
                }
                if k == "Container Total Space" {
                    di.containerTotalSpace = v
                }
                if k == "Container Free Space" {
                    di.containerFreeSpace = v
                }
            }
            disks[di.deviceIdentifier] = di
        }
        
        for (_, disk) in disks {
            if disk.whole == "No" {
                if let parent = disks[disk.partOfWhole] {
                    disk.deviceMediaName = parent.deviceMediaName
                }
            }
        }
        
        return disks
    }
}
