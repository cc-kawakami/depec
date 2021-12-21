module Depec
  module Target
    class CircleCi < Base
      #
      # @return [String]
      #
      def config_file
        File.join(@dir, '.circleci', 'config.yml')
      end

      #
      # @return [Boolean]
      #
      def used?
        File.exists?(config_file)
      end

      #
      # @return [Array]
      #
      def images
        images = []
        return images unless File.exists?(config_file)

        File.open(config_file) do |f|
          f.each_line do |line|
            if line.include?(' image:')
              images << line.match(/image: (?<image>.*)/)[:image]
            end
          end
        end

        images
      end
    end
  end
end
