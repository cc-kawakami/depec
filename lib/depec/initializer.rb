module Depec
  class Initializer
    attr_accessor :config

    #
    # @param [Hash] answers
    # @return 
    #
    def processAnswers(answers)
      Depec::Configuration.call({
        targets: {
          ruby: {
            use: answers[:ruby],
            version: answers[:ruby_version],
            bundler_version: answers[:bundler_version],
            gem_version: answers[:gem_version]
          },
          node: {
            use: answers[:node],
            version: answers[:node_version],
            npm_version: answers[:npm_version]
          },
          circle_ci: {
            use: answers[:circle_ci],
            images: answers[:circle_ci_images]
          },
          github_actions: {
            use: answers[:github_actions]
          }
        }
      }).to_h
    end
  end
end
