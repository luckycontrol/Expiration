//
//  FileManagerController.swift.swift
//  FileManagerController.swift
//
//  Created by 조종운 on 2021/08/16.
//

import Foundation
import UIKit

// MARK: 경로 반환 함수
func getDocumentDirectory() -> URL {
    let Urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    return Urls[0]
}

// MARK: 폴더 생성 함수 ( 계정 생성할 때 )
func makeDocumentFolder() {
    
    let finalRoot = getDocumentDirectory().appendingPathComponent("Expiration")
    
    do {
        try FileManager().createDirectory(atPath: finalRoot.path, withIntermediateDirectories: false, attributes: nil)
    } catch {
        print(error.localizedDescription)
    }
}

// MARK: 이미지 저장 함수
func saveImageInDocument(_ image: UIImage) -> URL {
    let imageData = image.jpegData(compressionQuality: 0.8)!
    
    let folderName = getDocumentDirectory()
    let fileName = folderName.appendingPathComponent("\(UUID()).jpg")
    
    do {
        try imageData.write(to: fileName)
    } catch {
        print(error.localizedDescription)
    }
    
    return fileName
}

// MARK: 이미지 변환 함수
func updateImageInDocument(_ fileName: String, _ image: UIImage) {
    let imageData = image.jpegData(compressionQuality: 0.8)!
    
    let filePath = URL(string: fileName)!
    
    do {
        try imageData.write(to: filePath)
    } catch {
        print(error.localizedDescription)
    }
}

// MARK: 이미지 삭제 함수
func removeImageInDocument(_ fileName: String) {
    
    let fileURL = URL(string: fileName)!
    
    do {
        try FileManager.default.removeItem(at: fileURL)
    } catch {
        print(error.localizedDescription)
    }
}

// MARK: 이미지 로딩
func loadImageInDocument(_ fileName: String) -> UIImage? {
    do {
        let fileURL = URL(string: fileName)!
        
        let imageData = try Data(contentsOf: fileURL)
        
        return UIImage(data: imageData)!
    } catch {
        print(error.localizedDescription)
    }
    
    return nil
}
