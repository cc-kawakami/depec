module Depec
  module Target
    class Node < Base
      #
      # @return [String]
      #
      def node_version_file
        File.join(@dir, '.node-version')
      end

      #
      # @return [String]
      #
      def package_json
        File.join(@dir, 'package.json')
      end

      #
      # @return [String]
      #
      def yarn_lock
        File.join(@dir, 'yarn.lock')
      end

      #
      # @return [Boolean]
      #
      def used?
        File.exists?(package_json)
      end
      
      #
      # @return [String]
      #
      def version
        if File.exists?(node_version_file)
          File.open(node_version_file) { |f| return f.gets.strip }
        elsif File.exists?(package_json)
          engine_section = false
          File.open(package_json) do |f|
            f.each_line do |line|
              engine_section = true if line.include?('"engines"')
              if engine_section && line.include?('"node"')
                return line.match(/"node": "(?<version>.*)"/)[:version]
              end
            end
          end

          return nil
        end
      end
  
      #
      # @param [String] npm
      # @return [String]
      #
      def npm_version(npm)
        return unless File.exists?(yarn_lock)
        
        version_line = false
        File.open(yarn_lock) do |f|
          f.each_line do |line|
            return line.match(/version \"(?<version>.*)\"/)[:version] if version_line
            version_line = true if line.match?(/^#{npm}@/)
          end
        end
        
        return nil
      end
    end
  end
end
