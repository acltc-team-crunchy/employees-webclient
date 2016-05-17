class Employee

  attr_accessor :id, :first_name, :last_name, :email, :birthday, :ssn

  def initialize(hash)
    @id = hash["id"]
    @first_name = hash["first_name"]
    @last_name = hash["last_name"]
    @email = hash["email"]
    @ssn = hash["ssn"]
    @birthday = hash["birthday"]
  end

  def full_name
    "#{@first_name} #{@last_name}"
  end

  def self.find(id)
    employee_hash = Unirest.get("#{ENV['DOMAIN']}/employees/#{id}.json").body
    return Employee.new(employee_hash)
  end

end