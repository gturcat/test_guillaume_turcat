require 'test_helper'

class DeskPolicyTest < ActiveSupport::TestCase
  def setup
    @guillaume = users(:guillaume)
    @roger = users(:roger)
    @desk = desks(:desk1)
    @desks = Desk.all
  end

  def test_update
    assert DeskPolicy.new(@guillaume, @desk).update?
    assert_not DeskPolicy.new(@roger, @desk).update?
  end

  def test_show
    assert DeskPolicy.new(@guillaume, @desk).show?
    assert DeskPolicy.new(@roger, @desk).show?
  end
end
