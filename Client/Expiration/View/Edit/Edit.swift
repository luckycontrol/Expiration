//
//  Edit.swift
//  Edit
//
//  Created by 조종운 on 2021/08/14.
//

import SwiftUI

struct Edit: View {
    
    @Environment(\.presentationMode) var presentationMode
    let generator = UIImpactFeedbackGenerator(style: .medium)

    @EnvironmentObject var appModel: AppModel

    @State private var _id = ""
    @State private var name = ""
    @State private var expiration = Date()
    @State private var image: UIImage?
    
    @State private var insertImage = false
    @State private var openImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType?
    
    @State private var addResult = ""
    @State private var addAlert = false

    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter
    }()

    init(_ product: ProductStructure) {
        self._id = product._id
        self.name = product.name
        self.expiration = dateFormatter.date(from: product.expiration) ?? Date()
        self.image = product.image == "" ? nil : UIImage(data: Data(base64Encoded: product.image)!)
    }
    
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
            title: Text("수정하는데 문제가 생겼어요!"),
            message: Text("\(addResult)."),
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
                                    Image(systemName: "photo.fill")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .scaledToFit()
                                    
                                    Text("\(appModel.selectedCateogry) 이미지를 넣어주세요.")
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
                    if(checkInputValid()) {
                        
                    }
                }) {
                    Text("\(appModel.selectedCateogry) 추가")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color("MenuColor"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .navigationBarTitle("\(appModel.selectedCateogry) 수정")
            .padding(30)
            .sheet(isPresented: $openImagePicker) {
                Camera(sourceType: sourceType, selectedImage: $image)
            }
            .alert(isPresented: $addAlert) { insertAlert }
        }
    }
    
    func checkInputValid() -> Bool {
        if (name == "") {
            addResult = "이름을 입력해주세요"
            addAlert = true
            
            return false
        }
        
        return true
    }
    
    // 이미지 인코딩
    func imageEncoding(_ image: UIImage) -> String {
        let image = image.jpegData(compressionQuality: 0)!
        return image.base64EncodedString()
    }
    
    func handleUpdateProduct() {
        let image = image == nil ? "" : imageEncoding(self.image!)
        let expiration = dateFormatter.string(from: self.expiration)
        
        ProductApi().updateProduct(appModel.email, _id, name, appModel.selectedCateogry, image, expiration) { status in
            
            if (!status) {
                addResult = "수정하는데 문제가 생겼어요!"
                addAlert = true
                return
            }
            
            generator.impactOccurred()
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct Edit_Previews: PreviewProvider {
    
    static let product = ProductStructure(_id: "", email: "", name: "", type: "", image: "", expiration: "")
    
    static var previews: some View {
        NavigationView {
            Edit(product)
                .environmentObject(AppModel())
        }
    }
}
