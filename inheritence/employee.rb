class Employee

  def initialize(name,title,salary,boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
    @bonus = 0
  end

  def bonus(multiplier)
    self.bonus = self.salary*multiplier
  end

end

class Manager < Employee

  def initialize(name,title,salary,boss, employees)
    super(name,title,salary,boss)
    @employees = employees
  end

  def bonus(multiplier)
    total_sal = 0
    self.employees.each do |employee|
      total_sal+=employee.salary
    end
    self.bonus = total_sal*multiplier
  end

end
