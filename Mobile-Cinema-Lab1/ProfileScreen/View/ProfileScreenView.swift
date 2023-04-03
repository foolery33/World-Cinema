//
//  ProfileScreenView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 03.04.2023.
//

import UIKit
import SnapKit

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
        myImageView.layer.cornerRadius = myImageView.frame.height / 2
        myImageView.image = UIImage(named: "TheMagicians")
        myImageView.clipsToBounds = true
        return myImageView
    }()
    private func setupAvatarImage() {
        avatarStack.addArrangedSubview(avatarImage)
        avatarImage.snp.makeConstraints { make in
            make.width.height.equalTo(88)
        }
    }
    
    // MARK: ChangeButton setup
    
    private lazy var changeButton: UIButton = {
        let myButton = UIButton(type: .system)
        myButton.setTitle("Изменить", for: .normal)
        myButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        myButton.setTitleColor(.redColor, for: .normal)
        return myButton
    }()
    
    // MARK: - UserInfoStack setup
    
    private lazy var userInfoStack: UIStackView = {
        let myStackView = UIStackView()
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
        myLabel.numberOfLines = 0
        myLabel.textColor = .white
        myLabel.font = .systemFont(ofSize: 24, weight: .bold)
        return myLabel
    }()
    
    // MARK: EmailLabel setup
    
    private lazy var emailLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.numberOfLines = 0
        myLabel.textColor = .grayColor
        myLabel.font = .systemFont(ofSize: 14, weight: .regular)
        return myLabel
    }()
    
    // MARK: - SectionsTableView setup
    
    private lazy var sectionsTableView: ProfileSectionsTableView = {
        let myTableView = ProfileSectionsTableView()
//        myTableView.backgroundColor = .white
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
//        viewModel.leaveAccount()
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
        let activityIndicator = ActivityIndicator()
        addSubview(activityIndicator)
        activityIndicator.setupAnimation()
        viewModel.getProfile { success in
            activityIndicator.stopAnimation()
            if(success) {
                self.updateDataOnScreen()
            }
            else {
                self.showAlert(title: "Profile Loading Failed", message: self.viewModel.error)
            }
        }
    }
    
    func updateDataOnScreen() {
        usernameLabel.text = "\(viewModel.profile.firstName) \(viewModel.profile.lastName)"
        emailLabel.text = viewModel.profile.email
        if viewModel.profile.avatar != nil {
            avatarImage.loadImageWithURL(viewModel.profile.avatar ?? "")
        }
    }
    
}
