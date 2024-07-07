import XCTest
@testable import DiskUtilInfoReader

final class DiskUtilInfoReaderTests: XCTestCase {
    
    func testRun() throws {
        
        let reader = DiskUtilInfoReader()
        
        let disks = reader.read()
        
        XCTAssertNotEqual(0, disks.values.count)
        
        for disk in disks.values.filter({ di in
            return di.whole == "No"
        }).sorted(by: { d1, d2 in
            return d1.deviceIdentifier < d2.deviceIdentifier
        }) {
            print("========")
            print(disk.deviceIdentifier)
            print(disk.volumeName)
            print(disk.mountPoint)
            print(disk.mounted)
            print(disk.deviceProtocol)
            print(disk.deviceMediaName)
            print(disk.fileSystem)
            print(disk.totalSpace())
            print(disk.freeSpace())
        }
        print("----------")
    }
}
