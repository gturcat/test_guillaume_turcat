require 'test_helper'
require 'rake'

class MailerTaskTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper

  setup do
    TestGuillaumeTurcat::Application.load_tasks #if Rake::Task.tasks.empty?
    @ben_request = requests(:ben_request)
    @lolo_request = requests(:lolo_request)
  end

  test "reconfirmation email is recieved" do
    assert_enqueued_emails 1 do
      Rake::Task['request:confirm_again'].invoke
      puts "test 1"
      puts enqueued_jobs.first
    end
    puts "enqueue test 1: #{enqueued_jobs.size}"
  end

  test "expired request are delete and ranking are updated" do
    clear_enqueued_jobs
    puts "enqueue debut test2: #{enqueued_jobs.size}"
    assert_enqueued_emails 1 do
      Rake::Task['request:expired_request'].invoke
      puts "test 2"
      puts enqueued_jobs.first
    end
    assert_equal 3, @ben_request.reload.ranking
    assert @lolo_request.reload.expired?
    puts "enqueue fin test2: #{enqueued_jobs.size}"
  end

end
