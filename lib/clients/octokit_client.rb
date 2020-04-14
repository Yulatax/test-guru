require 'octokit'

class OctokitClient

  ACCESS_TOKEN = ENV['GITHUB_ACCESS_TOKEN']

  def initialize
    @client = setup_client
  end

  def create_gists(options)
    @client.create_gist(options)
  end

  private

  def setup_client
    @client = Octokit::Client.new(:access_token => ACCESS_TOKEN)
  end
end