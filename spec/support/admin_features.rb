module AdminFeatures
  include Warden::Test::Helpers

  def create_user
    User.create(name: "Test Testerson", dob: "1985-05-05", email: "test@test.com", password: "123456")
  end

end
