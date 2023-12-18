//
//  QRCodeGenerator.swift
//  MiniSim
//
//  Created by Gokulakrishnan Subramaniyan on 16/12/23.
//

import AppKit
import CoreImage.CIFilterGenerator
import Foundation

struct QRCodeImageGenerator {
    func getQrName() -> String {
        let randomId = Int.random(in: 0..<5)
        let name = "ABD_WIFI_\(randomId)"
        let password = "MINISIM_ADB_WIFI_\(randomId)"
        print(name, password, "WIFI name")
        return "WIFI:T:ADB;S:\(name);P:\(password)"
    }

    func generateQRCode() -> NSImage? {
        let qrData = getQrName()
        let data = qrData.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                let rep = NSCIImageRep(ciImage: output)
                let nsImage = NSImage(size: rep.size)
                nsImage.addRepresentation(rep)
                return nsImage
            }
        }

        return NSImage()
    }
}
