I18n-validator
================================

https://github.com/rvanlieshout/i18n-validator

By Rene van Lieshout <rene@bluerail.nl>

Description
-----------

The I18n-validator gem provides a script that validates the I18n locale files in your Rails project. This version only checks for the presence of all entries in all available locales. The command should be run from the Rails.root; thus containing a config/locales/ folder.

Installation
------------

    sudo gem install i18n-validator

Or when using bundler, add to your Gemfile:

    gem "i18n-validator"

Usage
-----

    i18n-validate

Or when using bundler:

    bundle exec i18n-validate

Validation of missing entries
-----------------------------

Assume we have a project with three locales (de, en and nl). The complete set of entries in the locale files equals:

    de:
      foo:
        bar:
          baz: Baz!
    en:
      foo:
        bar:
          baz: Baz!
      hello:
        world: Hello World!
    nl:
      foo:
        bar:
          baz: Baz!
      hello:
        world: Hello World!
        kitty: Hello Kitty

When running `i18n-validate` a list of missing entries is displayed:

  - hello.kitty is missing in locales de and en
  - hello.world is missing in locale de

Planned features
----------------

The most common issue we've seen with I18n is the absence of entries. Future releases of this gem should warn for other I18n related mishaps. Feel free to create pull requests with checks that exposes any problems you had before. Besides that it should:

* Ignore entries that Rails already provides, such as 'activerecord.errors.messages.accepted is missing in locale en'

