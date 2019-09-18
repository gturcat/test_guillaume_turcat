require 'test_helper'

class FreedaysUdpateJobTest < ActiveJob::TestCase

 def setup
  @desk = desks(:desk1)
 end

  test 'recalculate freedays' do
    FreedaysUdpateJob.perform_now
    assert_equal 17, @desk.reload.freedays
  end
end
