# Depec

Analyze project directory's dependency spec.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "depec", git: "git@github.com:cc-kawakami/depec.git", tag: "v0.1.0"
```

And then execute:

    $ bundle

Or:

    $ gem install specific_install
    $ gem specific_install git@github.com:cc-kawakami/depec.git v0.1.0

## Usage

Initialize configuration:

```bash
bundle exec depec init
```

Analyze specified directory:

```bash
bundle exec depec analyze DIR --config=.depecrc.yml
```

If you want to output to JSON file,

```bash
bundle exec depec analyze DIR --config=.depecrc.yml --output=out.json
```
