//
//  Test.swift
//  Test
//
//  Created by eruYan on 2018/11/29.
//

import XCTest

class Test: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        debugPrint("测试用例")
        let root = KMLRoot()
        let doc = KMLDocument()

        root.feature = doc
        let floder = KMLFolder()
        doc.addFeature(floder)
        let pal = KMLPlacemark()
        let time = KMLTimeStamp()
        
        time.when = Date()
        pal.timePrimitive = time
        floder.addFeature(pal)
        pal.styleUrl = "#TrackStyle"
        let track = KMLGXTrack()
        track.addExtendedData(withName: "testAddExtendedData", value: "11")
        
        for _ in 0...10 {
            let cod = KMLGXCoordinate()
            cod.altitude = 11.0
            cod.latitude = 22.0
            cod.longitude = 33.0
            track.addCoordinate(cod)
            
            let when = KMLWhen()
            when.date = Date()
            track.addDate(when)
        }
        pal.geometry = track
        debugPrint("kml",root.kml() ?? "错误")
        
//        let xmlString = root.kml() ?? ""
//
//        guard let rs = KMLParser.parseKML(with: xmlString) else {
//            assert(false)
//            return
//        }
//
//        guard let padoc = rs.feature as? KMLDocument else {
//            assert(false)
//            return
//        }
//
//        let pfs = padoc.features ?? []
//
//        for item in pfs {
//            if let folde = item as? KMLFolder {
//                debugPrint("folde")
//                for pl in folde.features ?? [] {
//                    if let track = pl as? KMLPlacemark {
//                        debugPrint("解析初KMLPlacemark", track)
//                        debugPrint("解析初 geometry", track.geometry)
//                        debugPrint("解析初 geometry", NSStringFromClass(track.geometry.classForCoder))
//                        if let tl = track.geometry as? KMLGXTrack {
//                            debugPrint("coorde ", tl.coordinates.count)
//                            debugPrint("do date", tl.dates.count)
//                            let array = tl.coordinates as! [KMLGXCoordinate]
//                            debugPrint(array[0].altitude)
//                        }
//
//                    }
//                }
//            }
//        }
       
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
