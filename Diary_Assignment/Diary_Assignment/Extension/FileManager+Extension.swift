//
//  FileManager+Extension.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/10/07.
//


import UIKit

extension UIViewController {
    //도큐먼트 이미지 불러오는 메서드
    func loadImageFromDocument(fileName: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil } //실행중인 앱의 document 경로를 documentDirectory에 대입
        let fileURL = documentDirectory.appendingPathComponent(fileName) //document안에 저장된 fileName의 경로(이미지 저장 경로)
        
        //조건문으로 도큐먼트이미지 없을 때 디폴트 이미지 설정 가능
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            return UIImage(systemName: "star")
        }
    }
    
    //도큐먼트 이미지파일삭제 메서드
    func removeImageFromDocument(fileName: String){
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return } //실행중인 앱의 document 경로를 documentDirectory에 대입
        let fileURL = documentDirectory.appendingPathComponent(fileName) //document안에 저장된 fileName의 경로(이미지 저장 경로)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
    }
    
    func saveImageToDocument(fileName: String, image: UIImage) {
        //FileManager: 파일관리 메서드
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return } //실행중인 앱의 document 경로를 documentDirectory에 대입
        let fileURL = documentDirectory.appendingPathComponent(fileName) //document안에 저장된 fileName의 경로(이미지 저장 경로)
        
        //원본 대신 압축파일로 document에 저장 가능(용량 절약 가능)
        guard let data = image.jpegData(compressionQuality: 0.5) else { return } //용량 0.5배로 줄임
        
        //에러핸들링 추가
        do {
            try data.write(to: fileURL) //압축한 이미지데이터를 fileURL에 저장
        } catch let error {
            print("file save error", error)
        }
    }
}
