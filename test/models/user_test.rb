require 'test_helper'
#require 'support/database_cleaner'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Remote Zen", 
                     email: "remotezen@bell.net",
                     password: "foobar",
                     password_confirmation: "foobar")
  end

  test "should follow adn unfollow a user" do
    michael = users(:michael)
    archer = users(:archer)
    assert_not michael.following?(archer)
    michael.follow(archer)
    assert michael.following?(archer)
    assert archer.followers.include?(michael)
    michael.unfollow(archer)
    assert_not michael.following?(archer)
  end


  test "authenticated? should return false for a nil digest user" do
    assert_not @user.authenticated?(:remember, '')
  end

  
  
  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present " do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "email should be presence" do
    @user.email = "     "
    assert_not @user.valid?
  end
  test "name should not be too long" do
    long_name = "a" * 51
    @user.name = long_name
    assert_not @user.valid?
  end

  test "email should should not be too long" do
    long_email = "a" * 251
    @user.email = long_email
    assert_not @user.valid?
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org 
    user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?
     end
   end
  test "Email addresses must be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "Email addresses should be saved as downcase" do
    mixed_case_email = "ReMoTeZeN@bElL.nEt"
    @user.email = mixed_case_email
    @user.save
    assert_equal @user.email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password length should be greater than 5" do
    @user.password = @user.password_confirmation  = "a" * 5
    assert_not @user.valid?
  end
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end
  
  test "feed should have the right posts"   do
    michael = users(:michael)  
    fred = users(:fred)
    lana = users(:lana)
    lana.microposts.each do |post_following|
      assert michael.feed.include?(post_following)
    end
    michael.microposts.each do |post_self|
      assert michael.feed.include?(post_self)
    end
    fred.microposts.each do |post_unfollowed|
      assert_not michael.feed.include?(post_unfollowed)
    end
  end

end
