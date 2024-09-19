//
//  AddTaskController.swift
//  Task List
//
//  Created by Vasiliy Vygnych on 26.08.2024.
//

import UIKit
import SnapKit

class AddTaskController: UIViewController {
    
    var presenter: TaskPresenterProtocol?
    var dateOfCreation: String?
    weak var delegate: BaseViewDelegate?

    private var headerTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 30,
                                 weight: .bold)
        view.textAlignment = .left
        view.textColor = .black
        return view
    }()
    var closeButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setBackgroundImage(UIImage(named: "closeImage"),
                                for: .normal)
        return view
    }()
   
    private var nameLabel: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 14,
                                weight: .medium)
        view.textAlignment = .left
        return view
    }()
    private var nameView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "customGray")
        view.layer.cornerRadius = 12
        return view
    }()
    private var nameTextField: UITextField = {
       let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = .systemFont(ofSize: 14,
                                     weight: .medium)
        view.backgroundColor = .clear
        view.tintColor = .white
        return view
    }()
    private var placeholderName: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 14,
                                weight: .medium)
        view.textAlignment = .left
        view.alpha = 0.5
        return view
    }()
    
    private var dateLabel: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 14,
                                weight: .medium)
        view.textAlignment = .left
        return view
    }()
    private var dateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "customGray")
        view.layer.cornerRadius = 12
        return view
    }()
    private var dateTextField: UITextField = {
       let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = .systemFont(ofSize: 14,
                                     weight: .medium)
        view.backgroundColor = .clear
        view.tintColor = .clear
        return view
    }()
    var dataPicker: UIDatePicker = {
       let view = UIDatePicker()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.datePickerMode = .date
        view.preferredDatePickerStyle = .wheels
        view.backgroundColor = UIColor(named: "customGray")
        return view
    }()
    
    private var descriptionLabel: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 14,
                                weight: .medium)
        view.textAlignment = .left
        return view
    }()
    private var descriptionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "customGray")
        view.layer.cornerRadius = 12
        return view
    }()
    private var descriptionTextView: UITextView = {
       let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = .systemFont(ofSize: 14,
                                     weight: .medium)
        view.backgroundColor = .clear
        view.isScrollEnabled = false
        view.scrollsToTop = false
        return view
    }()
    private var placeholderDescription: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 14,
                                 weight: .medium)
        view.textAlignment = .left
        view.text = "Description"
        view.alpha = 0.5
        return view
    }()
    private var countLabel: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .lightGray
        view.font = .systemFont(ofSize: 12,
                                 weight: .light)
        view.textAlignment = .right
        return view
    }()
    private var saveButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "yellowCustom")
        view.titleLabel?.font = .systemFont(ofSize: 16,
                                            weight: .bold)
        view.setTitleColor(.black,
                           for: .normal)
        view.layer.cornerRadius = 20
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupeSubview()
        addConstraints()
        setupeButton()
        setupeData()
        setupDate()
    }
    private func setupeData() {
        headerTitle.text = "Adding a task"
        nameLabel.text = "Name of the task"
        placeholderName.text = "Name"
        dateLabel.text = "Date"
        descriptionLabel.text = "Description task"
        saveButton.setTitle("Save the task",
                            for: .normal)
    }
    private func setupeSubview() {
        view.addSubview(headerTitle)
        view.addSubview(closeButton)
        
        view.addSubview(nameLabel)
        view.addSubview(nameView)
        nameView.addSubview(nameTextField)
        nameTextField.delegate = self
        nameView.addSubview(placeholderName)
        
        view.addSubview(dateLabel)
        view.addSubview(dateView)
        dateView.addSubview(dateTextField)
        
        view.addSubview(descriptionView)
        view.addSubview(descriptionLabel)
        descriptionView.addSubview(descriptionTextView)
        descriptionView.addSubview(placeholderDescription)
        descriptionTextView.delegate = self
        descriptionView.addSubview(countLabel)
        
        view.addSubview(saveButton)
    }
    private func setupeButton() {
        closeButton.addTarget(self,
                              action: #selector(closeView),
                              for: .touchUpInside)
        saveButton.addTarget(self,
                             action: #selector(addNewTask),
                             for: .touchUpInside)
        dataPicker.addTarget(self,
                             action: #selector(choiceDate),
                             for: .valueChanged)
    }
    @objc func addNewTask() {
        presenter?.clickToAnimate(view: saveButton)
        presenter?.edirOrAddTask(.add,
                                 id: nil,
                                 name: nameTextField.text,
                                 description: descriptionTextView.text,
                                 dateOfCreation: dateOfCreation)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 ) {
            self.dismiss(animated: true) {
                guard let date = self.dateOfCreation else { return }
                self.delegate?.showTask(date: date)
            }
        }
    }
    @objc func closeView() {
        dismiss(animated: true)
    }
    @objc func choiceDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dateTextField.text = formatter.string(from: dataPicker.date)
        dateOfCreation = formatter.string(from: dataPicker.date)
    }
    private func setupDate() {
        dateTextField.inputView = dataPicker
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dataPicker.setValue(UIColor.white,
                                forKeyPath: "textColor")
        dateTextField.text = dateOfCreation
        guard let dateString = dateOfCreation else { return }
        dataPicker.date = formatter.date(from: dateString) ?? Date()
    }
    private func addConstraints() {
        headerTitle.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.width.equalToSuperview()
            make.left.equalTo(20)
            make.height.equalTo(33)
        }
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.right.equalTo(-20)
            make.width.height.equalTo(34)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(headerTitle.snp.bottom).offset(30)
            make.width.equalToSuperview().inset(20)
            make.left.left.equalTo(20)
            make.height.equalTo(15)
        }
        nameView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(20)
            make.left.left.equalTo(20)
            make.height.equalTo(53)
        }
        nameTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(15)
            make.width.equalToSuperview().inset(15)
        }
        placeholderName.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(15)
            make.width.equalToSuperview().inset(15)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(15)
            make.width.equalToSuperview().inset(20)
            make.left.left.equalTo(20)
            make.height.equalTo(15)
        }
        dateView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(20)
            make.left.left.equalTo(20)
            make.height.equalTo(53)
        }
        dateTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(15)
            make.width.equalToSuperview().inset(15)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(dateView.snp.bottom).offset(15)
            make.width.equalToSuperview().inset(20)
            make.left.left.equalTo(20)
            make.height.equalTo(15)
        }
        descriptionView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(20)
            make.left.left.equalTo(20)
            make.height.greaterThanOrEqualTo(65)
            make.height.lessThanOrEqualTo(160)
        }
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.width.equalToSuperview().inset(15)
            make.height.greaterThanOrEqualTo(38)
            make.left.equalTo(15)
            make.bottom.equalToSuperview().inset(10)
        }
        placeholderDescription.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(25)
            make.left.equalTo(15)
            make.width.equalToSuperview().inset(15)
        }
        countLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.width.equalTo(50)
            make.right.equalTo(-15)
            make.height.equalTo(15)
        }
        saveButton.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(20)
            make.left.equalTo(20)
            make.height.equalTo(56)
            make.bottomMargin.equalToSuperview().inset(30)
        }
    }
}
extension AddTaskController: UITextFieldDelegate,
                                UITextViewDelegate {
    func textField(_ textField: UITextField,
                  shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range,
                                                               with: string)
        nameTextField.text = newString
        placeholderName.isHidden = true
       return false
    }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        view.endEditing(true)
    }
    func textViewDidChange(_ textView: UITextView) {
        descriptionTextView.text = textView.text
        if textView.text == "" {
            placeholderDescription.isHidden = false
        } else {
            placeholderDescription.isHidden = true
        }
    }
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        let newText = (descriptionTextView.text as NSString).replacingCharacters(in: range,
                                                                           with: text)
        countLabel.text = "\(newText.count)/200"
        let numberOfChars = newText.count
        return numberOfChars < 200
    }
}
