require_relative 'log'
require 'test/unit'

class TestLog < Test::Unit::TestCase

  def test_add_basic
    log = Log.new()
    log.add_basic('Oranges')
    date = Date.today
    assert_equal(log.log[date].to_s, "#{Date.today}\nOranges\n", 'Should be oranges today')
  end

  def test_add
    log = Log.new
    log.add('Oranges', Date.today)
    date = Date.today
    assert_equal(log.log[date].to_s, "#{Date.today}\nOranges\n", 'Should be oranges today')
    log.add('Oranges', Date.today+1)
    assert_equal(log.log[date + 1].to_s, "#{Date.today+1}\nOranges\n", 'Should be oranges tomorrow')
  end
end