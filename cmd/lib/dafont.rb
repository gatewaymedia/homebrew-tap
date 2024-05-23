# typed: false
# frozen_string_literal: true

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

        # Checks the page content at the URL for new versions.
        #
        # @param url [String] the URL of the content to check
        # @param regex [Regexp, nil] a regex used for matching versions
        # @param provided_content [String, nil] content to use in place of
        #   fetching via `Strategy#page_content`
        # @return [Hash]
        def self.find_versions(url:, regex: nil, provided_content: nil, **_unused)
          page = Homebrew::Livecheck::Strategy.page_content(url)
          return [] if page.blank? || page[:content].blank?

          match = page[:content][/(?:Updated|First seen on DaFont):\s+([^<"]+)/i, 1]
          return [] unless match

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
