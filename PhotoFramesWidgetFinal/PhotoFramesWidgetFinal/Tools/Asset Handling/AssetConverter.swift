//
//  AssetConverter.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 12/26/20.
//

import Foundation
import PhotosUI

func convertToData(transformsData: Data, scaleFactorsData: Data) -> (transforms: [CGSize], scaleFactors: [CGFloat])? {
    guard let convertedTransforms: [CGSize] = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(transformsData) as? [CGSize] else { return nil }
    guard let convertedScaleFactors: [CGFloat] = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(scaleFactorsData) as? [CGFloat] else { return nil }
    return (convertedTransforms, convertedScaleFactors)
}

func getAssetThumbnailsFromIds(IDs: Data) -> [UIImage]? {
    // convert id data to array
    guard let idArray: [String] = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(IDs) as? [String] else { return nil }
    
    // get images from assets
    let manager = PHImageManager.default()
    let options = PHImageRequestOptions()
    options.isSynchronous = true
    options.isNetworkAccessAllowed = true
    options.deliveryMode = .opportunistic
    options.resizeMode = .fast
    
    var thumbnails: [UIImage] = []
    
    for id in idArray {
        //        manager.requestImageDataAndOrientation(for: fetchResults[i], options: options) { data, id, orientation, error in
        //            // Check data
        //            guard let data = data else { print("1"); return }
        //
        //            // Convert to UIImage / check
        //            guard let img = UIImage(data: data) else { return }
        //
        //            // Append image
        //            thumbnails.append(img)
        //        }
        
        let results = PHAsset.fetchAssets(withLocalIdentifiers: [id], options: nil)
        manager.requestImage(for: results[0], targetSize: CGSize(width: 750, height: 750), contentMode: .default, options: options) { image, error in
            guard let img = image else { return }
            
            // Append image
            thumbnails.append(img)
        }
    }
    
    return thumbnails
}

func getSmallAssetThumbnailsFromIds(IDs: Data) -> [UIImage]? {
    // convert id data to array
    guard let idArray: [String] = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(IDs) as? [String] else { return nil }
    
    // get images from assets
    let manager = PHImageManager.default()
    let options = PHImageRequestOptions()
    options.isSynchronous = true
    options.isNetworkAccessAllowed = true
    options.deliveryMode = .fastFormat

    var thumbnails: [UIImage] = []
    
    for id in idArray {
        let results = PHAsset.fetchAssets(withLocalIdentifiers: [id], options: nil)
        manager.requestImage(for: results[0], targetSize: CGSize(width: -1, height: -1), contentMode: .default, options: options)  { image, info  in
            guard let img = image else { return }
            thumbnails.append(img)
        }
    }
    
    return thumbnails
}
