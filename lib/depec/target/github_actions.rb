module Depec
  module Target
    class GithubActions < Base
      #
      # @return [String]
      #
      def workflows_dir
        File.join(@dir, '.github', 'workflows')
      end

      #
      # @return [Boolean]
      #
      def used?
        File.exist?(workflows_dir)
      end
    end
  end
end
