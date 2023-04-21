//
//  ProfileScreenView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 03.04.2023.
//

import UIKit
import SnapKit
import SkeletonView

class ProfileScreenView: UIView {

    var viewModel: ProfileScreenViewModel
    
    init(viewModel: ProfileScreenViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        setupScrollView()
    }
    
    // MARK: - ScrollView setup
    
    private lazy var scrollView: UIScrollView = {
        let myScrollView = UIScrollView()
        myScrollView.showsVerticalScrollIndicator = false
        return myScrollView
    }()
    private func setupScrollView() {
        addSubview(scrollView)
        setupContentView()
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    // MARK: - ContentView setup
    
    private lazy var contentView: UIView = {
        let myView = UIView()
        return myView
    }()
    private func setupContentView() {
        scrollView.addSubview(contentView)
        setupProfileHeader()
        setupSectionsTableView()
        setupExitButton()
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    // MARK: - ProfileHeader setup
    
    private lazy var profileHeader: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .horizontal
        myStackView.spacing = 16
        myStackView.alignment = .top
        return myStackView
    }()
    private func setupProfileHeader() {
        contentView.addSubview(profileHeader)
        setupAvatarStack()
        setupUserInfoStack()
        profileHeader.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - AvatarStack setup
    
    private lazy var avatarStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 1
        return myStackView
    }()
    private func setupAvatarStack() {
        profileHeader.addArrangedSubview(avatarStack)
        
        setupAvatarImage()
        avatarStack.addArrangedSubview(changeButton)
    }
    
    // MARK: AvatarImage setup
    
    private lazy var avatarImage: UIImageView = {
        let myImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 88, height: 88))
        myImageView.isSkeletonable = true
        myImageView.layer.cornerRadius = myImageView.frame.height / 2
        myImageView.clipsToBounds = true
        myImageView.contentMode = .scaleAspectFill
        return myImageView
    }()
    private func setupAvatarImage() {
        avatarStack.addArrangedSubview(avatarImage)
        avatarImage.snp.makeConstraints { make in
            make.width.height.equalTo(88)
        }
    }
    
    // MARK: ImagePicker setup
    
    private lazy var imagePicker: UIImagePickerController = {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        return vc
    }()
    @objc private func showImagePicker() {
        self.showAlertWithChoice()
    }
    
    // MARK: ChangeButton setup
    
    private lazy var changeButton: UIButton = {
        let myButton = UIButton(type: .system)
        myButton.setTitle("Изменить", for: .normal)
        myButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        myButton.setTitleColor(.redColor, for: .normal)
        myButton.addTarget(self, action: #selector(showImagePicker), for: .touchUpInside)
        return myButton
    }()
    
    // MARK: - UserInfoStack setup
    
    private lazy var userInfoStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.isSkeletonable = true
        myStackView.axis = .vertical
        myStackView.spacing = 4
        return myStackView
    }()
    private func setupUserInfoStack() {
        profileHeader.addArrangedSubview(userInfoStack)
        
        userInfoStack.addArrangedSubview(usernameLabel)
        userInfoStack.addArrangedSubview(emailLabel)
    }
    
    // MARK: UsernameLabel setup
    
    private lazy var usernameLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.isSkeletonable = true
        myLabel.skeletonTextNumberOfLines = 2
        myLabel.numberOfLines = 0
        myLabel.textColor = .white
        myLabel.font = .systemFont(ofSize: 24, weight: .bold)
        return myLabel
    }()
    
    // MARK: EmailLabel setup
    
    private lazy var emailLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.isSkeletonable = true
        myLabel.numberOfLines = 0
        myLabel.textColor = .grayColor
        myLabel.font = .systemFont(ofSize: 14, weight: .regular)
        return myLabel
    }()
    
    // MARK: - SectionsTableView setup
    
    private lazy var sectionsTableView: ProfileSectionsTableView = {
        let myTableView = ProfileSectionsTableView()
        myTableView.viewModel = self.viewModel
        return myTableView
    }()
    private func setupSectionsTableView() {
        contentView.addSubview(sectionsTableView)
        
        sectionsTableView.snp.makeConstraints { make in
            make.top.equalTo(profileHeader.snp.bottom).offset(44)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(sectionsTableView.countHeight())
        }
    }
    
    // MARK: - ExitButton setup
    
    private lazy var exitButton: OutlinedButton = {
        return OutlinedButton().getOutlinedButton(label: "Выход", selector: #selector(leaveAccount))
    }()
    @objc private func leaveAccount() {
        self.setupActivityIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.stopActivityIndicator()
            self.viewModel.leaveAccount()
        }
    }
    private func setupExitButton() {
        contentView.addSubview(exitButton)
        exitButton.snp.makeConstraints { make in
            make.top.equalTo(sectionsTableView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
    
    func loadProfile() {
        userInfoStack.showAnimatedSkeleton(usingColor: UIColor(red: 33/255, green: 21/255, blue: 18/255, alpha: 1))
        avatarImage.showAnimatedSkeleton(usingColor: UIColor(red: 33/255, green: 21/255, blue: 18/255, alpha: 1))
//        self.setupActivityIndicator()
        viewModel.getProfile { success in
//            self.stopActivityIndicator()
            if(success) {
                self.userInfoStack.hideSkeleton()
                self.updateDataOnScreen()
            }
            else {
                self.showAlert(title: "Profile Loading Failed", message: self.viewModel.error)
            }
        }
    }
    
    func setAvatar(imageData: Data, image: UIImage) {
        self.setupActivityIndicator()
        viewModel.setAvatar(imageData: imageData) { success in
            self.stopActivityIndicator()
            if(success) {
                self.avatarImage.image = image
            }
            else {
                self.showAlert(title: "Avatar Setting Failed", message: self.viewModel.error)
            }
        }
    }
    
    func updateDataOnScreen() {
        usernameLabel.text = "\(viewModel.profile.firstName) \(viewModel.profile.lastName)"
        emailLabel.text = viewModel.profile.email
        if viewModel.profile.avatar != nil {
            avatarImage.loadImageWithURL(viewModel.profile.avatar ?? "") {
                self.avatarImage.hideSkeleton()
            }
        }
    }
    
}

extension ProfileScreenView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        if let imageData = image.jpegData(compressionQuality: 0.3) {
            if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
                self.setAvatar(imageData: imageData, image: image)
            }
            else {
                self.showAlert(title: "Avatar Setting Failed", message: "Your file is corrupted")
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func showAlertWithChoice() {
        let alert = UIAlertController(title: "Выберите источник изображения", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Камера", style: .default, handler: { _ in
            self.imagePicker.sourceType = .camera
            if let viewController = self.next as? UIViewController {
                viewController.present(self.imagePicker, animated: true)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Фото", style: .default, handler: { _ in
            self.imagePicker.sourceType = .photoLibrary
            if let viewController = self.next as? UIViewController {
                viewController.present(self.imagePicker, animated: true)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: nil))
        if let viewController = self.next as? UIViewController {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
