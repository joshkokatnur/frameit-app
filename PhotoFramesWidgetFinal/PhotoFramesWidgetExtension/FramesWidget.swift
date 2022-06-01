//
//  FramesWidget.swift
//  FramesWidget
//
//  Created by Josh Kokatnur on 8/18/20.
//

import WidgetKit
import SwiftUI
import PhotosUI
import ImageIO

struct FrameIntentProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> FrameIntentEntry {
        return FrameIntentEntry(date: Date(), images: [], frameId: 1, categoryId: 1, customColor: "808080", transforms: [CGSize(width: 0, height: 0)], scaleFactors: [1], isPlaceholder: true)
    }

    func getSnapshot(for configuration: SelectWidgetIntent, in context: Context, completion: @escaping (FrameIntentEntry) -> Void) {
        //Obtain info for intent's index
        let defaultEntry = FrameIntentEntry(date: Date(), images: [], frameId: 1, categoryId: 1, customColor: "808080", transforms: [CGSize(width: 0, height: 0)], scaleFactors: [1], isPlaceholder: true)
        guard let nameID = configuration.frame?.usersName else { completion(defaultEntry); return }
        let imgObject = getCDObjectFromName(name: nameID)
        
        // get images / other data
        guard let imgIds = imgObject.imageIdentifiers else { completion(defaultEntry); return }
        guard let transformsData = imgObject.transforms else { completion(defaultEntry); return }
        guard let scaleFactorsData = imgObject.scaleFactors else { completion(defaultEntry); return }
        guard let croppingData = convertToData(transformsData: transformsData, scaleFactorsData: scaleFactorsData) else { completion(defaultEntry); return }
        guard let images = getAssetThumbnailsFromIds(IDs: imgIds) else { completion(defaultEntry); return }
        
        completion(FrameIntentEntry(date: Date(), images: images, frameId: Int(imgObject.frameId), categoryId: Int(imgObject.categoryId), customColor: imgObject.customColor ?? "808080", transforms: croppingData.transforms, scaleFactors: croppingData.scaleFactors, isPlaceholder: false)) //replaced results[i] with imgObject
    }

    func getTimeline(for configuration: SelectWidgetIntent, in context: Context, completion: @escaping (Timeline<FrameIntentEntry>) -> Void) {
        //Obtain info for intent's index
        let defaultEntry = FrameIntentEntry(date: Date(), images: [], frameId: 1, categoryId: 1, customColor: "808080", transforms: [CGSize(width: 0, height: 0)], scaleFactors: [1], isPlaceholder: true)
        let defaultTimeline = Timeline(entries: [defaultEntry], policy: .never)
        guard let nameID = configuration.frame?.usersName else { completion(defaultTimeline); print("error here 1"); return }
        let imgObject = getCDObjectFromName(name: nameID)
        
        //get images / other data
        guard let imgIds = imgObject.imageIdentifiers else { completion(defaultTimeline); return }
        guard let transformsData = imgObject.transforms else { completion(defaultTimeline); return }
        guard let scaleFactorsData = imgObject.scaleFactors else { completion(defaultTimeline); return }
        guard let croppingData = convertToData(transformsData: transformsData, scaleFactorsData: scaleFactorsData) else { completion(defaultTimeline); return }
        guard let images = getAssetThumbnailsFromIds(IDs: imgIds) else { completion(defaultTimeline); return }
        
        let entry = FrameIntentEntry(date: Date(), images: images, frameId: Int(imgObject.frameId), categoryId: Int(imgObject.categoryId), customColor: imgObject.customColor ?? "808080", transforms: croppingData.transforms, scaleFactors: croppingData.scaleFactors, isPlaceholder: false)
        completion(Timeline(entries: [entry], policy: .never))
    }
    
    func getCoreData() -> [Entity] {
        //Obtain coredata info
        let context = PersistenceController.shared.persistentContainer.viewContext
        var results: [Entity] = []
        do {
            results = try context.fetch(Entity.getAllItems())
        } catch let error as NSError {
            print("ERROR: \(error.localizedDescription)")
        }
        return results
    }

    func getCDObjectFromName(name: String) -> Entity {
        let context = PersistenceController.shared.persistentContainer.viewContext
        var results: [Entity] = []
        do {
            results = try context.fetch(Entity.getItemFromName(arguments: [name]))
        } catch let error as NSError {
            print("ERROR: \(error.localizedDescription)")
        }
        return results[0]
    }
}

struct FrameIntentEntry: TimelineEntry {
    var date: Date
    var images: [UIImage]
    var frameId: Int
    var categoryId: Int
    var customColor: String
    var transforms: [CGSize]
    var scaleFactors: [CGFloat]
    var isPlaceholder: Bool
}

@main
struct FrameIntentWidget: Widget {
    private let kind: String = "FrameIntentWidget"
    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: SelectWidgetIntent.self, provider: FrameIntentProvider()) { entry in
            FrameIntentWidgetView(images: entry.images, frameId: entry.frameId, categoryId: entry.categoryId, customColor: Color(UIColor(hex: entry.customColor) ?? UIColor.gray), transforms: entry.transforms, scaleFactors: entry.scaleFactors, isPlaceholder: entry.isPlaceholder)
        }
        .configurationDisplayName("FrameIt Widget")
        .description("Add one of the widgets below to view the frame you just created!")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct FrameIntentWidgetView: View {
    
    @State var images: [UIImage]
    @State var loaded = false
    var frameId: Int
    var categoryId: Int
    var customColor: Color
    var transforms: [CGSize]
    var scaleFactors: [CGFloat]
    var isPlaceholder: Bool
    
    var body: some View {
        if isPlaceholder {
            //display placeholder view
            FramePlaceholderView(preview: false)
        } else {
            //otherwise, retrieve array/get view via index
            getFrameArray(img: images, transforms: transforms, scaleFactors: scaleFactors, customColor: customColor, isPreview: false)[categoryId][frameId]
        }
    }
}













//    func convertToData(transformsData: Data, scaleFactorsData: Data) -> (transforms: [CGSize], scaleFactors: [CGFloat])? {
//        guard let convertedTransforms: [CGSize] = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(transformsData) as? [CGSize] else { return nil }
//        guard let convertedScaleFactors: [CGFloat] = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(scaleFactorsData) as? [CGFloat] else { return nil }
//        return (convertedTransforms, convertedScaleFactors)
//    }
//
//    func getAssetThumbnailsFromIds(IDs: String) -> [UIImage] {
//        // convert id string to array
//        let idArray = IDs.components(separatedBy: " *$PL1T* ")
//
//        // get assets from ids
//        let fetchResults = PHAsset.fetchAssets(withLocalIdentifiers: idArray, options: nil)
//
//        // get images from assets
//        let manager = PHImageManager.default()
//        let options = PHImageRequestOptions()
//        options.isSynchronous = true
//        options.isNetworkAccessAllowed = true
//
//        var thumbnails: [UIImage] = []
//
//        for i in 0..<fetchResults.count {
//            manager.requestImageDataAndOrientation(for: fetchResults[i], options: options) { data, id, orientation, error in
//                // Check data
//                guard let data = data else { print("1"); return }
//
//                // Convert to UIImage / check
//                guard let img = UIImage(data: data) else { return }
//
//                // Append image
//                thumbnails.append(img)
//            }
//        }
//
//        return thumbnails
//    }
//
//    func editRawData(data: [Data], cropRects: [CGRect]) -> [UIImage]? {
//        var imgArray: [UIImage] = []
//
//        //let imgs = downsampleAssets2(data: data, to: CGSize(width: 100, height: 100))
//        //guard let cgImgs = imgs else { return nil }
//
////        for i in 0..<cgImgs.count {
////            let rawData = pixelValues(fromCGImage: cgImgs[i])
////            guard let pixelData = rawData.pixelValues else { return nil }
////            let sortedData = pixelData.sorted()
////
////            guard let imgFromData = image(fromPixelValues: sortedData, width: rawData.width, height: rawData.height) else { return nil }
////            let finalImg = UIImage(cgImage: imgFromData)
////            imgArray.append(finalImg)
////        }
//
//        for i in 0..<data.count {
//            //let rawData = data[i].sorted() as [UInt8]
//            //let rawData = [UInt8](data[i])
//           // print(data[i])
//            //var rawData = data[i].bytes
//            //print(rawData.count)
//
//            //let convertedData = NSData(bytes: rawData, length: 2)
//            //let convertedData = rawData.data
//
//            guard let img = UIImage(data: data[i]) else { print("ERROR HERE 1"); return nil }
//            imgArray.append(img)
//        }
//
//        return imgArray
//    }
//
//    func pixelValues(fromCGImage imageRef: CGImage?) -> (pixelValues: [UInt8]?, width: Int, height: Int)
//    {
//        var width = 0
//        var height = 0
//        var pixelValues: [UInt8]?
//        if let imageRef = imageRef {
//            width = imageRef.width
//            height = imageRef.height
//            let bitsPerComponent = imageRef.bitsPerComponent
//            let bytesPerRow = imageRef.bytesPerRow
//            let totalBytes = height * bytesPerRow
//
//            let colorSpace = CGColorSpaceCreateDeviceGray()
//
//            var intensities = [UInt8](repeating: 0, count: totalBytes)
//
//            let contextRef = CGContext(data: &intensities, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: 0)
//            contextRef?.draw(imageRef, in: CGRect(x: 0.0, y: 0.0, width: CGFloat(width), height: CGFloat(height)))
//
//            pixelValues = intensities
//        }
//
//        return (pixelValues, width, height)
//    }
//
//    func image(fromPixelValues pixelValues: [UInt8]?, width: Int, height: Int) -> CGImage?
//    {
//        var imageRef: CGImage?
//        if var pixelValues = pixelValues {
//            let bitsPerComponent = 8
//            let bytesPerPixel = 1
//            let bitsPerPixel = bytesPerPixel * bitsPerComponent
//            let bytesPerRow = bytesPerPixel * width
//            let totalBytes = height * bytesPerRow
//
//            imageRef = withUnsafePointer(to: &pixelValues, {
//                ptr -> CGImage? in
//                var imageRef: CGImage?
//                let colorSpaceRef = CGColorSpaceCreateDeviceGray()
//                let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue).union(CGBitmapInfo())
//                let data = UnsafeRawPointer(ptr.pointee).assumingMemoryBound(to: UInt8.self)
//                let releaseData: CGDataProviderReleaseDataCallback = {
//                    (info: UnsafeMutableRawPointer?, data: UnsafeRawPointer, size: Int) -> () in
//                }
//
//                if let providerRef = CGDataProvider(dataInfo: nil, data: data, size: totalBytes, releaseData: releaseData) {
//                    imageRef = CGImage(width: width,
//                                       height: height,
//                                       bitsPerComponent: bitsPerComponent,
//                                       bitsPerPixel: bitsPerPixel,
//                                       bytesPerRow: bytesPerRow,
//                                       space: colorSpaceRef,
//                                       bitmapInfo: bitmapInfo,
//                                       provider: providerRef,
//                                       decode: nil,
//                                       shouldInterpolate: false,
//                                       intent: CGColorRenderingIntent.defaultIntent)
//                }
//
//                return imageRef
//            })
//        }
//
//        return imageRef
//    }
//
//    func downsampleAssets2(data: [Data], to pointSize: CGSize, scale: CGFloat = UIScreen.main.scale) -> [CGImage]? {
//        var downsampledImages: [CGImage] = []
//
//        for imageData in data {
//            // Create a CGImageSource
//            let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
//            guard let imageSource = CGImageSourceCreateWithData(imageData as CFData, imageSourceOptions) else { print("failed to create image source"); return nil }
//
//            // Calculate the desired dimension
//            let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
//
//            // Perform downsampling
//            let downsampleOptions = [
//                kCGImageSourceCreateThumbnailFromImageAlways: true,
//                kCGImageSourceShouldCacheImmediately: true,
//                kCGImageSourceCreateThumbnailWithTransform: true,
//                kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
//            ] as CFDictionary
//            guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else { print("cant downsample"); return nil }
//
//            downsampledImages.append(downsampledImage)
//        }
//
//        return downsampledImages
//    }
//
//
//    func getCoreData() -> [Entity] {
//        //Obtain coredata info
//        let context = PersistenceController.shared.persistentContainer.viewContext
//        var results: [Entity] = []
//        do {
//            results = try context.fetch(Entity.getAllItems())
//        } catch let error as NSError {
//            print("ERROR: \(error.localizedDescription)")
//        }
//        return results
//    }
//
//    func getCDObjectFromName(name: String) -> Entity {
//        let context = PersistenceController.shared.persistentContainer.viewContext
//        var results: [Entity] = []
//        do {
//            //results = try context.fetch(Entity.getItemFromName(arguments: [name]))
//            results = try context.fetch(Entity.getItemFromName(arguments: ["test3"]))
//        } catch let error as NSError {
//            print("ERROR: \(error.localizedDescription)")
//        }
//        return results[0]
//    }
//
//    func getAssetDataFromIds(IDs: String, cropStrRep: String) -> (imageData: [Data], cropRects: [CGRect]) {
//        // convert id string to array
//        let idArray = IDs.components(separatedBy: " *$PL1T* ")
//
//        // get assets from ids
//        let fetchResults = PHAsset.fetchAssets(withLocalIdentifiers: idArray, options: nil)
//
//        // get image from asset
//        let manager = PHImageManager.default()
//        let options = PHImageRequestOptions()
//        options.isSynchronous = true
//        options.isNetworkAccessAllowed = true
//
//        // convert crop rects string to array of strings
//        let cropStrArray = cropStrRep.components(separatedBy: " *$PL1T* ")
//
//        // create arrays
//        var imageData: [Data] = []
//        var cropRects: [CGRect] = []
//
//        // loop through all assets
//        for i in 0..<fetchResults.count {
//            // get image's data
//            manager.requestImageDataAndOrientation(for: fetchResults[i], options: options) { data, id, orientation, error in
//                guard let data = data else { return }
//                imageData.append(data)
//            }
//
//            // get image's crop rect
//            let pw = CGFloat(fetchResults[i].pixelWidth)
//            let ph = CGFloat(fetchResults[i].pixelHeight)
//
//            if 0 >= cropStrArray.count {
//                cropRects.append(CGRect(x: 0, y: 0, width: pw, height: ph))
//            } else {
//                cropRects.append(NSCoder.cgRect(for: cropStrArray[i]))
//            }
//        }
//
//        return (imageData, cropRects)
//    }
//
//    func cropAssets(imageData: [Data], cropRects: [CGRect]) -> [Data]? {
//        var croppedImageData: [Data] = []
//
//        for i in 0..<imageData.count - 1 {
//            //autoreleasepool {
//                // Two options:
//                // 1. convert to cgimage, crop
//                //guard let image = UIImage(data: imageData[i]) else { return nil }
////                var image = UIImage(data: imageData[i])
////                guard let cgImage = image?.cgImage else { return nil }
////                image = nil
////                guard let croppedImage = cgImage.cropping(to: cropRects[i]) else { return nil }
////                let croppedUIImage = UIImage(cgImage: croppedImage)
////                let data = autoreleasepool(invoking: { () -> Data? in
////                    return croppedUIImage.jpegData(compressionQuality: 0.0)
////                })
////                guard let imgData = data else { return nil}
////                //guard let data = croppedUIImage.jpegData(compressionQuality: 0) else { return nil } //memory spike here?
////                croppedImageData.append(imgData)
//
//            // 2. convert to uiimage, redraw
//            guard let image = UIImage(data: imageData[i]) else { return nil }
//            UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 0.0)
//            image.draw(at: CGPoint(x: -cropRects[i].origin.x, y: -cropRects[i].origin.y))
//            let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//
//            let data = croppedImage?.jpegData(compressionQuality: 0.0)
//            //}
//        }
//
//        return croppedImageData
//    }
//
//    func downsampleAssets(data: [Data], to pointSize: CGSize, scale: CGFloat = UIScreen.main.scale) -> [UIImage]? {
//        var downsampledImages: [UIImage] = []
//
//        for imageData in data {
//            // Create a CGImageSource
//            let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
//            guard let imageSource = CGImageSourceCreateWithData(imageData as CFData, imageSourceOptions) else { print("failed to create image source"); return nil }
//
//            // Calculate the desired dimension
//            let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
//
//            // Perform downsampling
//            let downsampleOptions = [
//                kCGImageSourceCreateThumbnailFromImageAlways: true,
//                kCGImageSourceShouldCacheImmediately: true,
//                kCGImageSourceCreateThumbnailWithTransform: true,
//                kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
//            ] as CFDictionary
//            guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else { print("cant downsample"); return nil }
//
//            downsampledImages.append(UIImage(cgImage: downsampledImage))
//        }
//
//        return downsampledImages
//    }
//
//
//
//    func getAssetThumbnailsUsingURLs(IDs: String, cropStrRep: String) -> [UIImage] {
//        // convert id string to array
//        let idArray = IDs.components(separatedBy: " *$PL1T* ")
//
//        // get assets from ids
//        let fetchResults = PHAsset.fetchAssets(withLocalIdentifiers: idArray, options: nil)
//
//        // convert crop rects string to array of strings
//        let cropStrArray = cropStrRep.components(separatedBy: " *$PL1T* ")
//
//        var thumbnails: [UIImage] = []
//
//        //for i in 0..<fetchResults.count {
//            // Format cropping rect
//            let pw = CGFloat(fetchResults[0].pixelWidth)
//            let ph = CGFloat(fetchResults[0].pixelHeight)
//
//            var cropRect: CGRect
//            if 0 >= cropStrArray.count {
//                cropRect = CGRect(x: 0, y: 0, width: pw, height: ph)
//            } else {
//                cropRect = NSCoder.cgRect(for: cropStrArray[0])
//            }
//
//            // Get image url
//            let asset = fetchResults[0]
//            asset.requestContentEditingInput(with: PHContentEditingInputRequestOptions()) { (editingInput, info) in
//                if let input = editingInput, let imgURL = input.fullSizeImageURL {
//                    print(imgURL)
//                    if let img = downsampleUsingURL(imageAt: imgURL, to: CGSize(width: 10, height: 10), cropRect: cropRect, ogSize: CGSize(width: pw, height: ph)) {
//                        print("gotten")
//                        thumbnails.append(img)
//                    }
//                }
//            }
//        //}
//        return thumbnails
//    }
//
//    func getAssetThumbnailsFromIds2(IDs: String, cropStrRep: String) -> [UIImage] {
//        // convert id string to array
//        let idArray = IDs.components(separatedBy: " *$PL1T* ")
//
//        // get assets from ids
//        let fetchResults = PHAsset.fetchAssets(withLocalIdentifiers: idArray, options: nil)
//
//        // get image from asset
//        let manager = PHImageManager.default()
//        let options = PHImageRequestOptions()
//        options.deliveryMode = .opportunistic
//        options.isSynchronous = true
//        options.isNetworkAccessAllowed = true
//        options.resizeMode = .exact
//
//        // convert crop rects string to array of strings
//        let cropStrArray = cropStrRep.components(separatedBy: " *$PL1T* ")
//
//        var thumbnails: [UIImage] = []
//        //var formattedData: [Data] = []
//
//        print(fetchResults.count)
//        for i in 0..<fetchResults.count {
//            autoreleasepool {
//                let pw = CGFloat(fetchResults[i].pixelWidth)
//                let ph = CGFloat(fetchResults[i].pixelHeight)
//
//                var cropRect: CGRect
//                if 0 >= cropStrArray.count {
//                    cropRect = CGRect(x: 0, y: 0, width: pw, height: ph)
//                } else {
//                    cropRect = NSCoder.cgRect(for: cropStrArray[i])
//                }
//
//                let adjustedCropRect = CGRect(x: cropRect.minX / pw, y: cropRect.minY / ph, width: cropRect.width / pw, height: cropRect.height / ph)
//                options.normalizedCropRect = adjustedCropRect
//
////                manager.requestImageDataAndOrientation(for: fetchResults[i], options: options) { data, id, orientation, error in
//////                    guard let data = data else { print("1"); return }
//////                    guard let img = UIImage(data: data) else { print("2"); return }
//////                    guard let cgimg = img.cgImage else { return }
//////                    guard let croppedimg = cgimg.cropping(to: cropRect) else { return }
//////                    let finalimg = UIImage(cgImage: croppedimg)
//////                    thumbnails.append(finalimg)
////
////                    // Convert data to cgimage
////                    guard let data = data else { print("1"); return }
////                    //guard let cgImg = UIImage(data: data)?.cgImage else { print("2"); return }
////
////                    // Crop it
////                    //guard let croppedImg = cgImg.cropping(to: cropRect) else { print("3"); return }
////
////                    // Convert back to uiimage
////                    //let croppedUIImg = UIImage(cgImage: croppedImg)
////                    //guard let croppedImgData = UIImage(cgImage: croppedImg).pngData() else { print("4"); return }
////
////
////                    guard let img = UIImage(data: data) else { return }
////                    // Append image
////                    thumbnails.append(img)
////                }
//
//                manager.requestImage(for: fetchResults[i], targetSize: CGSize(width: 350, height: 350), contentMode: .default, options: options) { image, error in
//                    autoreleasepool {
//                        guard let image = image else { return }
//                        thumbnails.append(image)
//                    }
//                }
//            }
//        }
//
//        return thumbnails
//    }
//
//    func downsampleUsingURL(imageAt imageURL: URL,
//                    to pointSize: CGSize,
//                    scale: CGFloat = UIScreen.main.scale, cropRect: CGRect, ogSize: CGSize) -> UIImage? {
//
//        // Create an CGImageSource that represent an image
//        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
//        guard let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, imageSourceOptions) else {
//            return nil
//        }
//
//        // Calculate the desired dimension
//        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
//
//        // Perform downsampling
//        let downsampleOptions = [
//            kCGImageSourceCreateThumbnailFromImageAlways: true,
//            kCGImageSourceShouldCacheImmediately: true,
//            kCGImageSourceCreateThumbnailWithTransform: true,
//            kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
//        ] as CFDictionary
//        guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
//            return nil
//        }
//
//        // Crop image
//        guard let croppedImage = downsampledImage.cropping(to: cropRect) else { return nil }
//
//        // Return the downsampled/cropped image as UIImage
//        return UIImage(cgImage: croppedImage)
//    }
//
//    func downsample(data: Data, to pointSize: CGSize, scale: CGFloat = UIScreen.main.scale, cropRect: CGRect, factor: CGFloat) -> UIImage? {
//        // Create a CGImageSource
//        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
//        guard let imageSource = CGImageSourceCreateWithData(data as CFData, imageSourceOptions) else { print("failed to create image source"); return nil }
//
//        // Calculate the desired dimension
//        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
//
//        // Perform downsampling
//        let downsampleOptions = [
//            kCGImageSourceCreateThumbnailFromImageAlways: true,
//            kCGImageSourceShouldCacheImmediately: true,
//            kCGImageSourceCreateThumbnailWithTransform: true,
//            kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
//        ] as CFDictionary
//        guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else { print("cant downsample"); return nil }
//
//        // Crop image
//        //let scaleX = pointSize.width / ogSize.width
//        //let scaleY = pointSize.height / ogSize.height
//        //let adjustedCropRect = CGRect(x: cropRect.minX * factor, y: cropRect.minY * factor, width: cropRect.width * factor, height: cropRect.height * factor)
//        //let adjustedCropRect = CGRect(x: cropRect.minX / pointSize.width, y: cropRect.minY / pointSize.height, width: cropRect.width / pointSize.width, height: cropRect.height / pointSize.height)
//        //guard let croppedImage = downsampledImage.cropping(to: adjustedCropRect) else { return nil }
//
//        //let adjustedCropRect = CGRect(x: cropRect.minX * pointSize.width, y: cropRect.minY * pointSize.height, width: cropRect.width * pointSize.width, height: cropRect.height * pointSize.height)
//
//        let adjustedCropRect = cropRect
//
//        // Crop image
//        let image = UIImage(cgImage: downsampledImage)
//        UIGraphicsBeginImageContextWithOptions(adjustedCropRect.size, false, 0.0)
//        image.draw(at: CGPoint(x: -adjustedCropRect.origin.x, y: -adjustedCropRect.origin.y))
//        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        // Return the downsampled/cropped image as UIImage
//        return croppedImage
//    }
//
////    func drawImgFromData(data: Data, cropRect: CGRect) -> UIImage? {
////        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
////        guard let imageSource = CGImageSourceCreateWithData(data as CFData, imageSourceOptions) else { print("failed to create image source"); return nil }
////    }
//
//    func cropImage2(rect: CGRect, cgImage: CGImage) -> UIImage? {
//        //crop image
//        guard let croppedImg = cgImage.cropping(to: rect) else { return nil }
//
//        return UIImage(cgImage: croppedImg, scale: 1.0, orientation: .up)
//    }






//struct SFrameBlackWhiteTESTING: View {
//    
//    var image: UIImage
//    var transform: CGSize
//    var scaleFactor: CGFloat
//    
//    var body: some View {
//        GeometryReader { geo in
//            ZStack {
//                Color.black
//                Color.white
//                    .frame(width: geo.size.width - (geo.size.height / 7.5), height: geo.size.height - (geo.size.height / 7.5))
//                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
//                    .innerShadow(radius: 8, color: UIColor.black.withAlphaComponent(0.18))
//                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
////                Image(uiImage: image)
////                    .resizable()
////                    .aspectRatio(contentMode: .fill)
//                CroppedImage(image: image, transform: transform, scaleFactor: scaleFactor)
//                    //.frame(width: geo.size.width - (geo.size.height / 3.75), height: geo.size.height - (geo.size.height / 3.75))
//                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
//                    .innerShadow(radius: 10, color: UIColor.black.withAlphaComponent(0.2))
//                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
//            }
//        }
//    }
//}


//extension Data {
//    var bytes : [UInt8]{
//        return [UInt8](self)
//    }
//}
//
//extension Array where Element == UInt8 {
//    var data : Data{
//        return Data(self)
//    }
//}
