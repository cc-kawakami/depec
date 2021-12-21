require 'dry/schema'

module Depec
  DEFAULT_CONFIG_FILE = '.depecrc.yml'
end

Depec::Configuration = Dry::Schema.Params do
  required(:targets).hash do
    optional(:ruby).hash do
      optional(:use).filled(:bool)
      optional(:version).filled(:bool)
      optional(:bundler_version).filled(:bool)
      optional(:gem_version).array(:str?)
    end

    optional(:node).hash do
      optional(:use).filled(:bool)
      optional(:version).filled(:bool)
      optional(:npm_version).array(:str?)
    end

    optional(:circle_ci).hash do
      optional(:use).filled(:bool)
      optional(:images).filled(:bool)
    end

    optional(:github_actions).hash do
      optional(:use).filled(:bool)
    end
  end
end
