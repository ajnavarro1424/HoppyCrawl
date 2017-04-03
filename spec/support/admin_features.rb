module AdminFeatures
  include Warden::Test::Helpers

  def create_user
    User.create(email: "test@test.com", password: "123456", dob: "1985-05-05" )
  end

end
