//
//  CreateCollectionScreenView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 05.04.2023.
//

import UIKit
import SnapKit

class CreateCollectionScreenView: UIView {

    var viewModel: CreateCollectionScreenViewModel
    
    init(viewModel: CreateCollectionScreenViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupSubviews()
        addKeyboardDidmiss()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupSubviews() {
        setupScrollView()
    }
    
    // MARK: Keyboard dismiss
    
    func addKeyboardDidmiss() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tapGesture)
    }
    @objc
    func dismissKeyboard() {
        self.endEditing(true)
    }
    
    // MARK: - ScrollView setup
    
    private lazy var scrollView: UIScrollView = {
        let myScrollView = UIScrollView()
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
        setupTextField()
        setupCollectionsIconStack()
        setupSaveCollectionButton()
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    // MARK: - TextField setup
    
    private lazy var textField: CreateCollectionTextField = {
        let myTextField = CreateCollectionTextField()
        return myTextField.getOutlinedTextField(text: "", placeholderText: R.string.createCollectionScreenStrings.placeholder_name(), selector: #selector(updateCollectionName(_:)))
    }()
    @objc func updateCollectionName(_ textField: OutlinedTextField) {
        viewModel.collectionName = textField.text ?? ""
    }
    private func setupTextField() {
        contentView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - CollectionIconStack setup
    
    private lazy var collectionIconStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .horizontal
        myStackView.spacing = 24
        myStackView.alignment = .center
        return myStackView
    }()
    private func setupCollectionsIconStack() {
        contentView.addSubview(collectionIconStack)
        collectionIconStack.addArrangedSubview(collectionIcon)
        collectionIconStack.addArrangedSubview(chooseIconButton)
        collectionIconStack.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(22)
        }
    }
    
    // MARK: CollectionIcon setup
    
    private lazy var collectionIcon: UIImageView = {
        let myImageView = UIImageView(image: UIImage(named: viewModel.iconName))
        myImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return myImageView
    }()
    private func setupCollectionIcon() {
        collectionIconStack.addArrangedSubview(collectionIcon)
        collectionIcon.snp.makeConstraints { make in
            make.height.width.equalTo(72)
        }
    }
    
    // MARK: ChooseIconButton setup
    
    private lazy var chooseIconButton: OutlinedButton = {
        let myButton = OutlinedButton().getOutlinedButton(label: R.string.createCollectionScreenStrings.choose_icon(), selector: #selector(chooseIcon))
        myButton.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return myButton
    }()
    @objc private func chooseIcon() {
        if let viewController = self.next as? CreateCollectionScreenViewController {
            viewController.present(IconSelectionScreenViewController(delegate: viewController), animated: true)
        }
    }
    
    // MARK: - SaveCollectionButton setup
    
    private lazy var saveCollectionButton: FilledButton = {
        let myButton = FilledButton().getFilledButton(label: R.string.createCollectionScreenStrings.save(), selector: #selector(saveCollection))
        return myButton
    }()
    @objc private func saveCollection() {
        if(EmptyFieldValidation().isEmptyField(viewModel.collectionName)) {
            self.showAlert(title: R.string.createCollectionScreenStrings.failed_to_save_collection(), message: R.string.createCollectionScreenStrings.non_empty_collection_name_warning())
            return
        }
        viewModel.createCollection(collectionName: viewModel.collectionName) { success in
            if(success) {
                self.showAlert(title: R.string.createCollectionScreenStrings.success(), message: "\(R.string.createCollectionScreenStrings.collection()) '\(self.viewModel.collectionName)' \(R.string.createCollectionScreenStrings.was_successfully_saved())")
            }
            else {
                self.showAlert(title: R.string.createCollectionScreenStrings.failed_to_save_collection(), message: self.viewModel.error)
            }
        }
    }
    private func setupSaveCollectionButton() {
        contentView.addSubview(saveCollectionButton)
        saveCollectionButton.snp.makeConstraints { make in
            make.top.equalTo(collectionIconStack.snp.bottom).offset(44)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
    
    func changeIcon(iconName: String) {
        self.collectionIcon.image = UIImage(named: iconName)
    }
    
}
