require "i18n"
require "i18n-validator/version"

module I18n
  module Validator
    #
    # Presents a list of missing locale entries
    #
    def self.missing_locales(path)
      I18n.load_path << path

      # Fetch all keys per locale
      keys_per_locale = Hash[I18n.available_locales.map{ |locale|
        [
          locale,
          I18n.translate('.', :locale => locale).map{ |key, value|
            self.convert_key_value_hash_to_array(key, value)
          }.flatten.sort
        ]
      }]

      if keys_per_locale.length <= 1
        # there couldn't be any missing locales
        # when we only have 1 locale...
        []
      else
        # Remap Hash to use values as keys
        locales_per_key = self.invert_key_value_hash(keys_per_locale)
        available_locales_length = I18n.available_locales.length
        locales_per_key.reject{ |key, locales|
          locales.length == available_locales_length
        }.sort{ |a,b|
          a[0] <=> b[0]
        }.map{ |key, locales|
          [key, (I18n.available_locales - locales).sort{ |a,b| a.to_s <=> b.to_s }]
        }
      end
    end

    private

    #
    # Converts a key-value(s) Hash to a Hash with
    # I18n-alike strings, such as:
    #
    # Input:
    #
    # en:
    #   user:
    #     edit:
    #       title: Edit user details
    #       submit_button: Save
    # nl:
    #   user:
    #     edit:
    #       title: Gebruikersgegevens bewerken
    #
    # Output:
    #
    # :en => [
    #   "user.edit.title",
    #   "user.edit.submit_button"
    # ]
    # :nl => [
    #   "user.edit.title"
    # ]
    #
    def self.convert_key_value_hash_to_array(key, value, parent_label = "")
      if value.is_a?(Hash)
        value.map do |subkey, subvalue|
          convert_key_value_hash_to_array(subkey, subvalue, "#{parent_label}#{key}.")
        end
      else
        "#{parent_label}#{key}"
      end
    end

    #
    # Remaps an Hash to use the key as value and vice versa
    #
    # A value which is available in multiple keys would result
    # in a key with multiple values
    #
    # Example input:
    #
    # :en => [
    #   "user.edit.title",
    #   "user.edit.submit_button"
    # ]
    # :nl => [
    #   "user.edit.title"
    # ]
    #
    # Result:
    #
    # [
    #   "user.edit.title" => [:en, :nl],
    #   "user.edit.submit_button" => [:en]
    # ] 
    #
    def self.invert_key_value_hash(keys_per_locale)
      keys_per_locale.invert.map{ |keys, locale|
        Hash[keys.map{ |key|
          [key, [locale]]
        }]
      }.reduce{ |keys_per_locale_1, keys_per_locale_2|
        keys_per_locale_1.merge!(keys_per_locale_2){ |key, locale_1, locale_2|
          locale_1 + locale_2
        }
      }
    end
  end
end