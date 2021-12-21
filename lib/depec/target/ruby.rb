module Depec
  module Target
    class Ruby < Base
      #
      # @return [String]
      #
      def ruby_version_file
        File.join(@dir, '.ruby-version')
      end

      #
      # @return [String]
      #
      def gemfile
        File.join(@dir, 'Gemfile')
      end

      #
      # @return [String]
      #
      def gemfile_lock
        File.join(@dir, 'Gemfile.lock')
      end

      #
      # @return [Boolean]
      #
      def used?
        File.exists?(gemfile)
      end

      #
      # @return [String]
      #
      def version
        return unless File.exists?(ruby_version_file)
        File.open(ruby_version_file) { |f| return f.gets.strip }
      end

      #
      # @return [String]
      #
      def bundler_version
        return unless File.exists?(gemfile_lock)

        version_line = false
        File.open(gemfile_lock) do |f|
          f.each_line do |line|
            return line.strip if version_line
            version_line = true if line.include?('BUNDLED WITH')
          end
        end

        return nil
      end

      #
      # @param [String] gem
      # @return [String]
      #
      def gem_version(gem)
        return unless File.exists?(gemfile_lock)
        
        File.open(gemfile_lock) do |f|
          f.each_line do |line|
            if line.match?(/ #{gem} \([0-9\.]+\)/)
              return line.match(/#{gem} \((?<version>.*)\)/)[:version]
            end
          end
        end
        
        return nil
      end
    end
  end
end
