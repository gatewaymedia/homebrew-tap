# typed: strict
# frozen_string_literal: true

require "date"

module Homebrew
  module Livecheck
    module Strategy
      # The {DaFont} strategy fetches content from a DaFont url and returns
      # the latest date of update.
      #
      # This strategy is not applied automatically and it's necessary to use
      # `strategy :dafont` in a `livecheck` block to apply it.
      #
      # @api private
      class Dafont
        NICE_NAME = "dafont"

        # The `Regexp` used to determine if the strategy applies to the URL.
        URL_MATCH_REGEX = %r{^https?://.+dafont}i

        # Whether the strategy can be applied to the provided URL.
        #
        # @param url [String] the URL to match against
        # @return [Boolean]
        sig { params(url: String).returns(T::Boolean) }
        def self.match?(url)
          URL_MATCH_REGEX.match?(url)
        end
        sig { returns(TrueClass) }
        def self.strategy_present?
          true
        end

        sig { returns(T::Hash[T.untyped, T.untyped]) }
        def self.parameters
          {
            url_match_regex: URL_MATCH_REGEX,
          }
        end

        sig {
          params(url: String, regex: T.nilable(Regexp), provided_content: T.nilable(String),
                 _unused: T.untyped).returns(T::Hash[Symbol, T.untyped])
        }
        def self.find_versions(url:, regex: nil, provided_content: nil, **_unused)
          page = Homebrew::Livecheck::Strategy.page_content(url)
          return { matches: {}, url: } if page.blank? || page[:content].blank?

          updated = page[:content][/(?:Updated):\s+([^<"]+)/i, 1]
          first_seen = page[:content][/(?:First seen on DaFont):\s+([^<"]+)/i, 1]
          match = updated || first_seen
          return { matches: {}, url: } unless match

          year = match.split(",").last.tr(" ", "")
          month = Date::MONTHNAMES.index(match.split(",").first.split.first).to_s.rjust(2, "0")
          day = match.split(",").first.split.last

          version_text = "#{year}#{month}#{day}"

          match_data = { matches: {}, url: }

          match_data[:matches][version_text] = Version.new(version_text)

          match_data
        end
      end
    end
  end
end
