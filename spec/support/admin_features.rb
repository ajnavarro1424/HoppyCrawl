module AdminFeatures
  include Warden::Test::Helpers

  def create_user
    User.create(name: "Test Testerson", dob: "1985-05-05", email: "test@test.com", password: "123456")
  end

  def create_admin
    User.create(name: "Admin Testerson", dob:"1985-05-05", email:"admin@test.com", password:"123456")
  end

  def create_user_2
    User.create(name: "Test McTester", dob: "1978-05-05", email: "Mac@McTest.com", password: "123456")

  end

end
