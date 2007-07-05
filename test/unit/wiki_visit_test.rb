require File.dirname(__FILE__) + '/../test_helper'

class WikiVisitTest < Test::Unit::TestCase
  fixtures :wiki_visits

  def setup
    @visit = WikiVisit.find 1
  end

  # Replace this with your real tests.
  def test_accessors
    assert_kind_of WikiVisit, @visit
    assert_kind_of WikiPage, @visit.wiki_page
    assert_kind_of User, @visit.user
    assert_equal Time.parse("2007-01-08 00:43:00"), @visit.time_of_visit
  end
end
