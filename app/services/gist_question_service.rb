class GistQuestionService

  def initialize(question, client: nil)
    @question = question
    @test = @question.test
    #@client = client || GitHubClient.new
    @client = client || OctokitClient.new
  end

  def call
    @client.create_gists(gist_params)
  end

  def success?
    @client.octokit_client.last_response.status == 201 ? true : false
  end

  private

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