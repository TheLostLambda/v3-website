require 'test_helper'

class Notifications::CreateTest < ActiveSupport::TestCase
  test "create db record" do
    user = create :user
    type = :mentor_started_discussion
    discussion = create(:solution_mentor_discussion)
    params = { discussion: discussion }

    notification = Notification::Create.(user, type, params)

    assert_equal 1, Notification.count
    assert_equal user, notification.user
    assert_equal Notifications::MentorStartedDiscussionNotification, notification.class
    assert_equal 1, notification.version
    assert_equal "#{user.id}-mentor_started_discussion-Discussion##{discussion.id}", notification.anti_duplicate_key
    assert_equal params, notification.send(:params)
  end
end
