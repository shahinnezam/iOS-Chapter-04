// Create a Struct with Properties: firstName, lastName, fullname, (private) birthday, and age

import Foundation
struct Student{
    //Stored Properties
    var firstName:String
    var lastName:String
    var studentID:String
    var month:Int
    var day:Int
    var year:Int
    var _password:String?
    {
        didSet{
            print("Your password was changed from \(oldValue) to \(_password!)")
        }
    }
    
    // Computed Properties
    var fullName:String { return "\(firstName) \(lastName)"}
    var password:String {
        get
        {
            // Password has been set
            if let _password = _password { return _password }
            // Provide initial, temporary password
            let last4 = studentID.suffix(4)
            return "\(lastName)\(last4)"
        }
        set{
            _password = newValue
        }
    }
    var birthday:String { return "Birthday is: \(month)/\(day)/\(year)"}
    var age:Int {
        get {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy"
        let dateYear = df.string(from: date)
        if let dateYear = Int(dateYear) { return dateYear - year }
        return 0
        }
    }
}

var Ian = Student(firstName: "Ian", lastName:"Bansenauer", studentID: "920111123", month: 09, day: 10, year: 1985)

print("Initial password: " + Ian.password)
//Set Password
Ian.password = "testPassword"
Ian.password = "Fabul0_346"
print(Ian.birthday)
print(Ian.age)
