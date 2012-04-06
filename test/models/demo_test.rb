require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class DemoTest < Test::Unit::TestCase
  context "Demo Model" do
    should 'construct new instance' do
      @demo = Demo.new
      assert_not_nil @demo
    end
  end
end
