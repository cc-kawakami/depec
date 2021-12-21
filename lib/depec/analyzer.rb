require_relative 'configuration'
Dir.glob(__dir__ + '/target/*.rb').each {|f| require_relative f }

module Depec
  class Analyzer
    #
    # @param [String]
    # @param [Hash]
    #
    def initialize(dir, config)
      @dir = dir
      @name = File.basename(@dir)
      @config = Configuration.call(config).to_h
    end

    #
    # @return [Hash]
    #
    def analyze
      results = {
        name: @name
      }

      @config[:targets].each do |target, options|
        klass = Object.const_get("Depec::Target::#{target.to_s.split('_').collect!{ |w| w.capitalize }.join}").new(@dir)
        results[target] = klass.used? if options[:use]
        if [:ruby, :node].include?(target)
          results[:"#{target}_version"] = klass.version if options[:version]
        end
        if target == :circle_ci
          results[:circle_ci_images] = klass.images if options[:images]
        end
        if target == :ruby
          results[:bundler_version] = klass.bundler_version if options[:bundler_version]
          options[:gem_version]&.each do |gem|
            results[:"#{gem}_gem"] = klass.gem_version(gem)
          end
        end
        if target == :node
          options[:npm_version]&.each do |npm|
            results[:"#{npm}_npm"] = klass.npm_version(npm)
          end
        end
      end

      results
    end
  end
end
