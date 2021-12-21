RSpec.describe Depec::Initializer do
  def answers
    {
      ruby: true,
      ruby_version: true,
      bundler_version: true,
      gem_version: ['rails', 'jekyll'],
      node: true,
      node_version: true,
      npm_version: ['vue', 'react'],
      circle_ci: false,
      circle_ci_images: false,
      github_actions: false,
    }
  end

  def initializer
    Depec::Initializer.new
  end

  describe "#processAnawers" do
    it {
      config = initializer.processAnswers(answers)

      expected = {
        targets: {
          ruby: {
            use: true,
            version: true,
            bundler_version: true,
            gem_version: ['rails', 'jekyll']
          },
          node: {
            use: true,
            version: true,
            npm_version: ['vue', 'react']
          },
          circle_ci: {
            use: false,
            images: false
          },
          github_actions: {
            use: false
          }
        }
      }
      is_asserted_by { config == expected }
    }
  end
end
