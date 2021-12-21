require 'json'
require 'yaml'
require 'thor'
require 'tty-prompt'

require_relative 'analyzer'
require_relative 'initializer'
require_relative 'configuration'

module Depec
  class CLI < Thor
    #
    # @param [String] dir
    #
    desc "analyze DIR", "Analyze project dependency spec"
    method_option "config", desc: "config", default: Depec::DEFAULT_CONFIG_FILE
    method_option "output", desc: "output", default: nil
    def analyze(dir)
      result = Depec::Analyzer.new(dir, YAML.load_file(options["config"])).analyze
      if options["output"]
        File.open(options["output"], "w+") do |f|
          f.write(result.to_json)
        end
      else
        puts JSON.pretty_generate(result)
      end
    end

    desc "init", "Initialize depec configuration"
    def init
      prompt = TTY::Prompt.new
      initializer = Depec::Initializer.new

      answers = {
        ruby: prompt.yes?("? Do you want to know whether Ruby is used?: "),
        ruby_version: prompt.yes?("? Do you want to know Ruby version?: "),
        bundler_version: prompt.yes?("? Do you want to know Bundler version?: "),
        gem_version: prompt.ask("? Gem name that do you want to know version: ", default: "rails, jekyll", convert: :array),
        node: prompt.yes?("? Do you want to know whether Node.js is used?: "),
        node_version: prompt.yes?("? Do you want to know Node.js version?: "),
        npm_version: prompt.ask("? Npm package name that do you want to know version: ", default: "vue, react", convert: :array),
        circle_ci: prompt.yes?("? Do you want to know whether CircleCI is used?: "),
        circle_ci_images: prompt.yes?("? Do you want to know CircleCI images?: "),
        github_actions: prompt.yes?("? Do you want to know whether GitHub Actions is used?: "),
      }

      config = initializer.processAnswers(answers)

      File.open(Depec::DEFAULT_CONFIG_FILE, 'w+') do |f|
        f.write(YAML.dump(config))
      end
    end
  end
end
