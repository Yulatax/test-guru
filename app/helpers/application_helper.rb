module ApplicationHelper

  GITHUB = 'https://github.com'

  def current_year
    Time.now.year
  end

  def github_url(author, repo)
    "#{GITHUB}/#{author}/#{repo}"
  end
end
