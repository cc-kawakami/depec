# Depec

Analyze project directory's dependency spec.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "depec", github: "cc-kawakami/depec", tag: "v0.1.0"
```

And then execute:

    $ bundle

Or:

    $ gem install specific_install
    $ gem specific_install https://github.com/cc-kawakami/depec.git v0.1.0

## Usage

Initialize configuration:

```bash
bundle exec depec init
? Do you want to know whether Ruby is used?:  Yes
? Do you want to know Ruby version?:  Yes
? Do you want to know Bundler version?:  Yes
? Gem name that do you want to know version:  rails, jekyll
? Do you want to know whether Node.js is used?:  Yes
? Do you want to know Node.js version?:  Yes
? Npm package name that do you want to know version:  vue, react
? Do you want to know whether CircleCI is used?:  Yes
? Do you want to know CircleCI images?:  Yes
? Do you want to know whether GitHub Actions is used?:  Yes
```

Analyze specified directory:

```bash
bundle exec depec analyze DIR --config=.depecrc.yml
{
  "name": DIR_NAME,
  "ruby": true,
  "ruby_version": "2.6.9",
  "bundler_version": "2.2.32",
  "rails_gem": null,
  "jekyll_gem": null,
  "node": true,
  "node_version": "14.15.1",
  "vue_npm": "3.0.7",
  "react_npm": null,
  "circle_ci": true,
  "circle_ci_images": [
    "cimg/ruby:2.6.9-node",
    "cimg/postgres:12.9"
  ],
  "github_actions": false
}
```

If you want to output to JSON file,

```bash
bundle exec depec analyze DIR --config=.depecrc.yml --output=out.json
```
