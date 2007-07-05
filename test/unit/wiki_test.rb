require File.dirname(__FILE__) + '/../test_helper'

class WikiTest < Test::Unit::TestCase
  fixtures :wikis, :wiki_pages

  def setup
    @wiki = Wiki.find 1
  end

  # Replace this with your real tests.
  def test_accessors
    assert_not_nil @wiki
    assert_kind_of Wiki, @wiki
    assert_equal "Wikipedia (en)", @wiki.name
    assert_equal "http://en.wikipedia.org", @wiki.homepage 
    assert_equal "http://en.wikipedia.org/wiki/", @wiki.base_url
    assert_not_nil @wiki.wiki_pages
    assert_kind_of Array, @wiki.wiki_pages
    assert_equal 1, @wiki.wiki_pages.length
    assert_kind_of WikiPage, @wiki.wiki_pages[0]
  end
  
end
