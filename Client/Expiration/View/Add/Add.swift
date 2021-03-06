//
//  Add.swift
//  Expiration
//
//  Created by 조종운 on 2021/05/13.
//

import SwiftUI

struct Add: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.managedObjectContext) private var viewContext
    
    let generator = UIImpactFeedbackGenerator(style: .medium)
    
    @EnvironmentObject var appModel: AppModel
    
    @State private var name = ""
    @State private var expiration = Date()
    @State private var image: UIImage?
    
    @State private var insertImage = false
    @State private var openImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType?
    
    @State private var addResult = ""
    @State private var addAlert = false
    
    var body: some View {
        let insertActionSheet = ActionSheet(
            title: Text("사진을 추가해주세요."),
            message: Text("어떤 방식으로 추가하실건가요?"),
            buttons: [
                .default(Text("카메라로 직접 촬영")) {
                    sourceType = .camera
                    openImagePicker = true
                    generator.impactOccurred()
                },
                .default(Text("앨범에서 선택")) {
                    sourceType = .photoLibrary
                    openImagePicker = true
                    generator.impactOccurred()
                },
                .cancel(Text("취소"))
            ]
        )
        
        let insertAlert = Alert(
            title: Text(addResult),
            message: Text("다시 한 번 시도해주세요."),
            dismissButton: Alert.Button.cancel(Text("확인"))
        )
        
        ZStack {
            Color.black.opacity(0.05).edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                if image != nil {
                    Image(uiImage: image!)
                        .resizable()
                        .frame(height: 300)
                        .cornerRadius(15)
                        .shadow(color: .black, radius: 0.22, x: 0.2, y: 0.2)
                        .scaledToFit()
                        .onTapGesture {
                            insertImage = true
                        }
                        .actionSheet(isPresented: $insertImage) {
                            insertActionSheet
                        }
                } else {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.white)
                        .frame(height: 300)
                        .shadow(color: .black, radius: 0.2, x: 0.22, y: 0.22)
                        .overlay(
                            ZStack(alignment: .center) {
                                VStack {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .scaledToFit()
                                    
                                    Text("\(appModel.selectedCategory) 이미지를 넣어주세요.")
                                        .fontWeight(.medium)
                                        .padding(.top, 8)
                                }
                            }
                        )
                        .onTapGesture {
                            insertImage = true
                        }
                        .actionSheet(isPresented: $insertImage) {
                            insertActionSheet
                        }
                }
                
                VStack(spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("이름")
                            .font(.body)
                            .fontWeight(.medium)
                        
                        TextField("", text: $name)
                        Divider()
                    }
                    
                    VStack(alignment: .leading) {
                        Text("유통기한")
                            .font(.body)
                            .fontWeight(.medium)
                        
                        DatePicker("", selection: $expiration, in: Date()..., displayedComponents: .date)
                    }
                }
                .padding(.top, 30)
                
                
                Spacer()
                
                Button(action: {
                    if (itemCheck()) {
                        add()
                    }
                }) {
                    Text("\(appModel.selectedCategory) 추가")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color("MenuColor"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("\(appModel.selectedCategory) 추가")
            .padding(30)
            .sheet(isPresented: $openImagePicker) {
                Camera(sourceType: sourceType, selectedImage: $image)
            }
            .alert(isPresented: $addAlert) { insertAlert }
        }
    }
    
    func itemCheck() -> Bool {
        if (name == "" || image == nil) {
            addResult = "이름과 이미지를 모두 채워주세요."
            addAlert = true
            return false
        }
        
        return true
    }
    
    // 추가
    func add() {
        let imagePath = "\(saveImageInDocument(image!))"
        
        let expiration = changeExpiration(expiration)
        let newProduct = createProductObject(imagePath, expiration)
        
        ProductApi().createProduct(newProduct) { status, product in
            if (status) {
                DispatchQueue.main.async {
                    generator.impactOccurred()
                    presentationMode.wrappedValue.dismiss()
                }
            } else {
                DispatchQueue.main.async {
                    addResult = "\(name)을 추가하는데 문제가 생겼어요!"
                    addAlert = true
                }
            }
        }
    }
    
    // 이미지 인코딩
    func imageEncoding(_ image: UIImage) -> String {
        let image = image.jpegData(compressionQuality: 0)!
        return image.base64EncodedString()
    }
    
    // 바디에 넣을 오브젝트 생성
    func createProductObject(_ encodedImage: String, _ expiration: String) -> RequestCreateProduct {
        let object = RequestCreateProduct(email: appModel.email, productName: name, category: appModel.selectedCategory, image: encodedImage, expiration: expiration)
        
        return object
    }
    
    // 날짜 Date -> String
    func changeExpiration(_ expiration: Date) -> String {
        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
            return dateFormatter
        }()
        
        return dateFormatter.string(from: expiration)
    }
}

struct Add_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            Add()
                .environmentObject(AppModel())
        }
    }
}
