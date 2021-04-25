class Student
  attr_accessor :name, :grade
  attr_reader :id
  #read the read me only a reader for id and should be set to nil
def initialize(id = nil, name, grade)
  #make sure you set id to nil because id will be assigned with integer primary key when added to database.
  @name = name 
  @grade = grade
end

def self.create_table
  sql = <<-SQL
  CREATE TABLE students (
    id INTEGER PRIMARY KEY,
    name TEXT,
    grade INTEGER
  );
  SQL
  DB[:conn].execute(sql)
end

def self.drop_table
  sql = <<-SQL 
  DROP TABLE students;
  SQL
  DB[:conn].execute(sql)
end

def save 
  sql = <<-SQL 
  INSERT INTO students (name, grade) 
  VALUES (?,?)
  SQL
  DB[:conn].execute(sql, self.name, self.grade)
  @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  #grabs id and reassigns it 
end

def self.create(name:, grade:)
student = Student.new(name, grade)
#create a new student ruby object
student.save
#save that object in the database
student
#return the student ruby object
end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
end
