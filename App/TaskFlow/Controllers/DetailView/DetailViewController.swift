

import UIKit
import SnapKit
import CoreData

class DetailViewController: UIViewController {
    
    var presenter: TaskPresenterProtocol?
    var model: TaskModel?
    var dateOfCreation: String?
    weak var delegate: BaseViewDelegate?
   
    private var headerTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 30,
                                 weight: .bold)
        view.textAlignment = .right
        view.textColor = .black
        return view
    }()
    var backButton: UIButton = {
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
    private var countLabel: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .lightGray
        view.font = .systemFont(ofSize: 12,
                                 weight: .light)
        view.textAlignment = .right
        return view
    }()
    private var completedSwitch: UISwitch = {
       let view = UISwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor(named: "yellowCustom")?.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    private var statusLabel: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 20,
                                weight: .semibold)
        view.textAlignment = .left
        view.textColor = .black
        view.alpha = 0.5
        return view
    }()
    private var statusView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 24/2
        view.backgroundColor = .systemRed
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
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .lightGray
        setupeSubview()
        addConstraints()
        setupeButton()
        setupDate()
    }
    private func setupDate() {
        dateOfCreation = model?.dateOfCreation
        nameTextField.text = model?.todoName
        descriptionTextView.text = model?.todoDescription
        guard let text = descriptionTextView.text else { return }
        countLabel.text = "\(text.count)/200"
        
        dateTextField.inputView = dataPicker
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dataPicker.setValue(UIColor.white,
                                forKeyPath: "textColor")
        dateTextField.text = dateOfCreation
        guard let dateString = dateOfCreation else { return }
        dataPicker.date = formatter.date(from: dateString) ?? Date()
        headerTitle.text = "Edit a task"
        nameLabel.text = "Name of the task"
        dateLabel.text = "Date"
        saveButton.setTitle("Back",
                            for: .normal)
        statusLabel.text = "Task completed"
        
        if model?.completed == true {
            completedSwitch.isOn = true
            isOn()
        } else {
            completedSwitch.isOn = false
            isOff()
        }
    }
    private func setupeSubview() {
        view.addSubview(headerTitle)
        view.addSubview(backButton)
        
        view.addSubview(nameLabel)
        view.addSubview(nameView)
        nameView.addSubview(nameTextField)
        nameTextField.delegate = self
        
        view.addSubview(dateLabel)
        view.addSubview(dateView)
        dateView.addSubview(dateTextField)
        
        view.addSubview(descriptionView)
        view.addSubview(descriptionLabel)
        descriptionView.addSubview(descriptionTextView)
        descriptionTextView.delegate = self
        descriptionView.addSubview(countLabel)
        
        view.addSubview(completedSwitch)
        view.addSubview(statusLabel)
        view.addSubview(statusView)
        
        view.addSubview(saveButton)
    }
    private func setupeButton() {
        backButton.addTarget(self,
                              action: #selector(popToView),
                              for: .touchUpInside)
        saveButton.addTarget(self,
                             action: #selector(editTask),
                             for: .touchUpInside)
        dataPicker.addTarget(self,
                             action: #selector(choiceDate),
                             for: .valueChanged)
        completedSwitch.addTarget(self,
                                  action: #selector(switchChanged),
                                  for: .valueChanged)
    }
    @objc func switchChanged(_ sender: UISwitch) {
        saveButton.setTitle("Save",
                            for: .normal)
           if sender.isOn {
               isOn()
           } else {
               isOff()
           }
       }
    private func isOn() {
        completedSwitch.layer.borderWidth = 0
        statusLabel.alpha = 1
        statusView.backgroundColor = .systemGreen
        presenter?.saveCompleted(id: Int(model?.id ?? 0),
                                 status: true)
    }
   private func isOff() {
        completedSwitch.layer.borderWidth = 1
        statusLabel.alpha = 0.5
        statusView.backgroundColor = .systemRed
        presenter?.saveCompleted(id: Int(model?.id ?? 0),
                                 status: false)
    }
    @objc func editTask() {
        presenter?.clickToAnimate(view: saveButton)
        presenter?.edirOrAddTask(.edit,
                                 id: Int(model?.id ?? 0),
                                 name: nameTextField.text,
                                 description: descriptionTextView.text,
                                 dateOfCreation: dateOfCreation)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 ) {
            guard let date = self.dateOfCreation else { return }
            self.delegate?.showTask(date: date)
            self.navigationController?.popViewController(animated: false)
        }
    }
    @objc func popToView() {
        navigationController?.popViewController(animated: false)
    }
    @objc func choiceDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dateTextField.text = formatter.string(from: dataPicker.date)
        dateOfCreation = formatter.string(from: dataPicker.date)
        saveButton.setTitle("Save",
                            for: .normal)
    }
    private func addConstraints() {
        headerTitle.snp.makeConstraints { make in
            make.top.equalTo(60)
            make.width.equalToSuperview()
            make.right.equalTo(-20)
            make.height.equalTo(33)
        }
        backButton.snp.makeConstraints { make in
            make.top.equalTo(60)
            make.left.equalTo(20)
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
        countLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.width.equalTo(50)
            make.right.equalTo(-15)
            make.height.equalTo(15)
        }
        completedSwitch.snp.makeConstraints { make in
            make.top.equalTo(descriptionView.snp.bottom).offset(20)
            make.left.equalTo(20)
        }
        statusLabel.snp.makeConstraints { make in
            make.centerY.equalTo(completedSwitch.snp.centerY)
            make.left.equalTo(completedSwitch.snp.right).inset(-15)
            make.height.equalTo(30)
            make.width.greaterThanOrEqualTo(50)
        }
        statusView.snp.makeConstraints { make in
            make.centerY.equalTo(statusLabel.snp.centerY)
            make.left.equalTo(statusLabel.snp.right).inset(-15)
            make.width.height.equalTo(24)
        }
        saveButton.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(20)
            make.left.equalTo(20)
            make.height.equalTo(56)
            make.bottomMargin.equalToSuperview().inset(30)
        }
    }
}
extension DetailViewController: UITextFieldDelegate,
                                UITextViewDelegate {
    func textField(_ textField: UITextField,
                  shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range,
                                                               with: string)
        nameTextField.text = newString
        saveButton.setTitle("Save",
                            for: .normal)
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
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        let newText = (descriptionTextView.text as NSString).replacingCharacters(in: range,
                                                                           with: text)
        countLabel.text = "\(newText.count)/200"
        saveButton.setTitle("Save",
                            for: .normal)
        let numberOfChars = newText.count
        return numberOfChars < 200
    }
}
