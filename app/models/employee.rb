class Employee

  attr_accessor :id, :first_name, :last_name, :email, :birthday, :ssn, :addresses

  def initialize(hash)
      @id = hash["id"]
      @first_name = hash["first_name"]
      @last_name = hash["last_name"]
      @email = hash["email"]
      @ssn = hash["ssn"]
      @birthday = hash["birthday"]
      @addresses = hash["addresses"]
  end

  def self.find(id)
    hash = Unirest.get("#{ENV['DOMAIN']}/employees/#{id}").body
    return Employee.new(hash)
  end

  def self.all
    hashes = Unirest.get("#{ENV['DOMAIN']}/employees").body
    employees = []
    hashes.each do |hash|
      employees << Employee.new(hash)
    end
    return employees
  end

  def self.create(attributes)
    employee_hash = Unirest.post("#{ENV['DOMAIN']}/employees.json", headers: {"Accept" => "application/json"}, parameters: attributes).body
    Employee.new(employee_hash)
  end

  def update(attributes)
    employee_hash = Unirest.patch("#{ENV['DOMAIN']}/employees/#{id}.json", headers: {"Accept" => "application/json"}, parameters: attributes).body
    Employee.new(employee_hash)
  end

  def destroy
    Unirest.delete("#{ENV['DOMAIN']}/employees/#{id}").body
  end


end