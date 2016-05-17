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

  def self.all
    employee_hashes = Unirest.get("#{ENV['DOMAIN']}/employees.json").body
    @employees = []
    employee_hashes.each do |hash|
      @employees << Employee.new(hash)
    end
    return @employees
  end

  def self.create(parameters_hash)
    employee_hash = Unirest.post("#{ENV['DOMAIN']}/employees.json", headers: {"Accept" => "application/json"}, parameters: parameters_hash).body
    return Employee.new(employee_hash)
  end

  def destroy
    return Unirest.delete("#{ENV['DOMAIN']}/employees/#{id}").body
  end

end