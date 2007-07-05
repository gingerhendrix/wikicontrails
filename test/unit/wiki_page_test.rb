require File.dirname(__FILE__) + '/../test_helper'

class WikiPageTest < Test::Unit::TestCase
  fixtures :wikis, :wiki_pages

  def setup
    @page = WikiPage.find 1
  end


  # Replace this with your real tests.
  def test_accessors
    assert_not_nil @page
    assert_kind_of WikiPage, @page
    assert_equal "Smoke_ring", @page.name
    assert_equal "Smoke ring", @page.title
    assert_not_nil @page.wiki
    assert_kind_of Wiki, @page.wiki 
  end
end
