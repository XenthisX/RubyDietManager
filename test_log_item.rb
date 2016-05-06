require_relative 'log_item'
require 'test/unit'
require 'date'

class TestLogItem < Test::Unit::TestCase
  def test_create_log_item
    log_item = LogItem.new('Test',Date.today)
    assert_equal(log_item.to_s, "#{Date.today}\nTest\n", 'to_string output should equal this')
  end

  def test_add_item
    log_item = LogItem.new('Test',Date.today)
    log_item.add_item('Foo')
    log_item.add_item('Bar')
    assert_equal(log_item.names.size, 3, '3 items should be in names Hash')
    assert_equal(log_item.names['Foo'], 1, '1 instance of Foo in Hash')
    assert_equal(log_item.names['Bar'], 1, '1 instance of Bar in Hash')
  end

  def test_add_same_item
    log_item = LogItem.new('Test',Date.today)
    log_item.add_item('Foo')
    log_item.add_item('Foo')
    log_item.add_item('Foo')
    log_item.add_item('Foo')
    log_item.add_item('Foo')
    log_item.add_item('Foo')
    assert_equal(log_item.names.size, 2, '2 items should be in names Hash')
    assert_equal(log_item.names['Foo'], 6, '6 instance of Foo in Hash')
  end
end