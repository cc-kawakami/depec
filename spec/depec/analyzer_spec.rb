RSpec.describe Depec::Analyzer do
  def config
    {
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
          npm_version: ['vue']
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
  end

  def analyzer
    Depec::Analyzer.new(
      File.join(__dir__ + '/../fixtures/sample_project'),
      config
    )
  end

  describe "#analyze" do
    it {
      expected = {
        name: 'sample_project',
        ruby: true,
        ruby_version: '3.0.3',
        bundler_version: '2.2.32',
        rails_gem: '7.0.0',
        jekyll_gem: nil,
        node: true,
        node_version: '16.x',
        vue_npm: '2.6.14'
      }
      is_asserted_by { analyzer.analyze == expected }
    }
  end
end
