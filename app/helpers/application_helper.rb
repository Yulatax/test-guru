module ApplicationHelper

  GITHUB = 'https://github.com'

  def current_year
    Time.now.year
  end

  def github_url(author, repo)
    link_to repo, "#{GITHUB}/#{author}/#{repo},", target: "_blank"
  end
end
