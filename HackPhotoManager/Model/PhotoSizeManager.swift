//
//  PhotoSizeManager.swift
//  HackPhotoManager
//
//  Created by WU CHIH WEI on 2017/10/1.
//  Copyright © 2017年 lukewu. All rights reserved.
//

import Foundation

enum PhotoSize: Double {
    case size300_400 = 0.1
    case size600_800 = 0.2
    case size900_1200 = 0.3
    case size1200_1600 = 0.4
    case size1500_2000 = 0.5
    case size1800_2400 = 0.6
    case size2100_2800 = 0.7
    case size2400_3200 = 0.8
    case size2700_3600 = 0.9
    case size3000_4000 = 1.0
    
    func representString() -> String {
        switch self {
        case .size300_400:
            return "300 X 400"
        case .size600_800:
            return "600 X 800"
        case .size900_1200:
            return "900 X 1200"
        case .size1200_1600:
            return "1200 X 1600"
        case .size1500_2000:
            return "1500 X 2000"
        case .size1800_2400:
            return "1800 X 2400"
        case .size2100_2800:
            return "2100 X 2800"
        case .size2400_3200:
            return "2400 X 3200"
        case .size2700_3600:
            return "2700 X 3600"
        case .size3000_4000:
            return "3000 X 4000"
        }
    }
}

class PhotoSizeManager {
    
    let photoSizes:[PhotoSize] = [.size600_800, .size1200_1600, .size1800_2400, .size2400_3200, .size3000_4000]
}
