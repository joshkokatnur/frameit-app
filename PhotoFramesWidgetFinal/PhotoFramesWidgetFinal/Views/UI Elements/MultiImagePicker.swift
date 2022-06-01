//
//  PhotoPickerWithCrop.swift
//  PhotoFramesWidgetFinal
//
//  Created by Josh Kokatnur on 9/19/20.
//

import SwiftUI
import PhotosUI

struct MultiImagePicker: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    var selectionLimit: Int
    @Binding var images: [UIImage]?
    @Binding var photoIDs: [String]?
    @Binding var numMissingPhotos: Int
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MultiImagePicker>) -> PHPickerViewController {
        let photoLibrary = PHPhotoLibrary.shared()
        var config = PHPickerConfiguration(photoLibrary: photoLibrary)
        
        config.selectionLimit = selectionLimit
        config.filter = PHPickerFilter.images
        
        //present limited picker if that access if given
        let picker = PHPickerViewController(configuration: config)
        
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: UIViewControllerRepresentableContext<MultiImagePicker>) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
        let parent: MultiImagePicker
        
        init(_ parent: MultiImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            guard results.count != 0 else { picker.dismiss(animated: true, completion: nil); return }
            
            let identifiers: [String] = results.compactMap(\.assetIdentifier)
            self.parent.photoIDs = identifiers
            
            self.parent.images = []

            for id in identifiers {
                let results = PHAsset.fetchAssets(withLocalIdentifiers: [id], options: nil)
                if let result = results.firstObject {
                    let img = self.getAssetThumbnail(asset: result, size: CGSize(width: 250, height: 250))
                    self.parent.images?.append(img)
                }
            }
            
            if let imgs = self.parent.images {
                self.parent.numMissingPhotos = results.count - imgs.count
            }
        }
        
        func getAssetThumbnail(asset: PHAsset, size: CGSize) -> UIImage {
            let manager = PHImageManager.default()
            let options = PHImageRequestOptions()
            var thumbnail = UIImage()
            options.isSynchronous = true
            options.isNetworkAccessAllowed = true
            options.resizeMode = .none
            options.deliveryMode = .opportunistic
            
            manager.requestImage(for: asset, targetSize: size, contentMode: .default, options: options) { result, info in
                if let img = result {
                    thumbnail = img
                }
            }
            
            return thumbnail
        }
    }
}
