require 'octokit'

class GistQuestionService

  ACCESS_TOKEN = ENV['GITHUB_ACCESS_TOKEN']

  def initialize(question, client: nil)
    @question = question
    @test = @question.test
    #@client = client || GitHubClient.new
    @client = client || setup_client
  end

  def call
    @client.create_gist(gist_params)
  end

  def success?
    @client.last_response.status == 201 ? true : false
  end

  private

  def setup_client
    Octokit::Client.new(:access_token => ACCESS_TOKEN)
  end

  def gist_params
    {
        description: I18n.t('test_passages.gist.description', title: @test.title),
        public: true,
        files: {
            "test-guru-question#{@question.id}.txt" => {
                content: gist_content
            }
        }
    }
  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end
end